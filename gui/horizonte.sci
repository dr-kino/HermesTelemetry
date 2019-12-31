function horizonte()
    
    xdel(winsid())
    
    n=500;
    //gera dados dummy senoidais para o horizonte artificial
    for i=1:n
        phi(i)=sin(1*i*%pi/180)*30;
    end
    
    for i=1:n
        theta(i)=sin(5*i*%pi/180)*5;
    end
    
    npc=11;
    for i=1:npc
        ang=-60+((i-1)/(npc-1))*120;
        xc(i)=sin(ang*%pi/180)*0.8;
        yc(i)=cos(ang*%pi/180)*0.8;
    end
    
    cor0=color('white');
    cor1=color('scilabbrown3');
    cor2=color('scilabblue2');
    cor3=color('yellow');
            
    fig=figure(3);
    fig.figure_position=[600,0];
    fig.figure_size=[500,750];
    fig.background=8;
    fig.toolbar_visible='off';
    fig.menubar_visible='off';
    fig.infobar_visible='off';
    fig.background=8;
    a=gca();
    a.data_bounds=[-1,-1;1,1];
    a.box='off';
    a.clip_state='off';
    a.axes_visible=['off','off','off'];
    a.auto_ticks=['off','off','off'];
    a.auto_margins='off';
    a.tight_limits='on';
    a.auto_scale='off';
    a.isoview='on';
    a.grid_style=[3,3];
    a.grid=[-1,-1,-1];
    a.x_label.text='';
    a.y_label.text='';
    a.z_label.text='';
    
    //pontos de linhas auxiliares de arfagem
    angs=[-20 -10 10 20];
    comp=[0.3 0.2 0.2 0.3];
    nangs=size(angs,2);
    for j=1:nangs
        pt2(j,1)=comp(j)
        pt2(j,2)=angs(j)/90;
        pt1(j,1)=-comp(j);
        pt1(j,2)=angs(j)/90;
    end
    
    //pontos de linhas auxiliares de rolamento
    angs2=[-60 -30 0 30 60];
    comp2=[0.1 0.1 0.1 0.1 0.1]
    nangs2=size(angs2,2);
    for j=1:nangs2
        pt2phi(j,1)=sin(angs2(j)*%pi/180)*(0.8+comp2(j));
        pt2phi(j,2)=cos(angs2(j)*%pi/180)*(0.8+comp2(j));
        pt1phi(j,1)=sin(angs2(j)*%pi/180)*0.8;
        pt1phi(j,2)=cos(angs2(j)*%pi/180)*0.8;
    end
    
    //pontos do horizonte
    p1=[1000 0];
    p2=[-1000 0];
    //pontos da terra
    pe1=[1000 -10];
    pe2=[-1000 -10];
    //pontos do ceu
    ps1=[1000 10];
    ps2=[-1000 10];
    //pontos da seta indicadora de rolamento
    pa1=[0 0.7];
    pa2=[0 0.8];
    
    //plota linhas auxiliares de rolamento
    for j=1:nangs2
        plot2d([pt1phi(j,1) pt2phi(j,1)],[pt1phi(j,2) pt2phi(j,2)],style=cor0);
    end
    
    //plota linha de horizonte
    plot2d([-0.8 -0.2],[0 0],style=cor3);
    p=get('hdl');
    p.children.thickness=2;
    plot2d([0.2 0.8],[0 0],style=cor3);
    p=get('hdl');
    p.children.thickness=2;
    plot2d(0,0,style=cor3);
    p=get('hdl');
    p.children.mark_mode='on';
    p.children.mark_size=1;
    p.children.mark_foreground=cor3;
    p.children.mark_style=4;
    
    //plota circulo de rolamento
    plot2d(xc,yc,style=cor0);
    p=get('hdl');
    p.children.thickness=2;
    
    //plota os dados a cada 33ms============================
    frequ=30;
    realtimeinit(1/frequ);//define frequencia de plotagem
    realtime(0);//define tempo inicial como zero
    i=1;
    tic
    while i<=n//, realtime(i)
        
        //matriz de rotacao
        matrot=[cos(phi(i)*%pi/180) -sin(phi(i)*%pi/180);sin(phi(i)*%pi/180) cos(phi(i)*%pi/180)];
        //define a reta a ser plotada, com centro em [0 0]
        p1p=matrot*(p1+[0 theta(i)/90])';
        p2p=matrot*(p2+[0 theta(i)/90])';
        pe1p=matrot*(pe1+[0 theta(i)/90])';
        pe2p=matrot*(pe2+[0 theta(i)/90])';
        ps1p=matrot*(ps1+[0 theta(i)/90])';
        ps2p=matrot*(ps2+[0 theta(i)/90])';
        pa1p=matrot*(pa1)';
        pa2p=matrot*(pa2)';
        
        //plota terra e ceu
        x=[pe2p(1) pe1p(1) p1p(1) p2p(1) pe2p(1); ps2p(1) p2p(1) p1p(1) ps1p(1) ps2p(1)];
        y=[pe2p(2) pe1p(2) p1p(2) p2p(2) pe2p(2); ps2p(2) p2p(2) p1p(2) ps1p(2) ps2p(2)];
        z=[-1 -1 -1 -1 -1; -1 -1 -1 -1 -1];
        plot3d(x',y',list(z',[cor1 cor2]));
        //plota linha de atitude
        //plot2d([p1p(1) p2p(1)],[p1p(2) p2p(2)],style=cor0);

        //rotaciona e plota linhas auxiliares
        for j=1:nangs
            pt1p(j,:)=matrot*(pt1(j,:)+[0 theta(i)/90])';
            pt2p(j,:)=matrot*(pt2(j,:)+[0 theta(i)/90])';
            x1(j,1)=pt1p(j,1)
            x1(j,2)=pt2p(j,1)
            y1(j,1)=pt1p(j,2)
            y1(j,2)=pt2p(j,2)
            //plot2d([pt1p(1) pt2p(1)],[pt1p(2) pt2p(2)],style=cor0);
        end
        plot3d(x1',y1',[0 0;0 0;0 0;0 0]');
        a=gca();
        a.children(1).foreground=cor0
        //plota seta indicadora de rolamento
        plot2d([pa1p(1) pa2p(1)],[pa1p(2) pa2p(2)],style=cor3);
        p=get('hdl');
        p.children.thickness=2;
        p.children.arrow_size_factor=2;
        p.children.polyline_style=4;
        a=gca();
        a.rotation_angles=[0 270];
        a.isoview='on';
        i=i+1;
        drawnow();
        drawlater();
        delete(a.children(1:3));
    end
    
    tempo=toc();
    mprintf('frequencia de plotagem: %.3f Hz',n/tempo)
    
endfunction
