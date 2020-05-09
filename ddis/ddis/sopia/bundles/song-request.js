sopia.var.songReq = [];

sopia.on('message', (e) => {
    if ( e.isCmd || isCmd(e) ) {
        const cmd = e.message.trim();
        if ( e.cmd === "ფ 신청곡 ⋆⁺₊⋆" ) {
            if ( cmd === "ფ 신청곡 ⋆⁺₊⋆" ) {
                if ( sopia.var.songReq.length === 0 ) {
                    sopia.send("현재 신청곡이 없습니다.");
                } else {
                    let rtn = "";
                    sopia.var.songReq.forEach((s, idx) => {
                        rtn += `${parseInt(idx,10)+1}. ${s}`;
                        if ( idx < sopia.var.songReq.length - 1 ) {
                            rtn += '\n';
                        }
                    });
                    sopia.debug(rtn);
                    sopia.send("ფ 신청곡 ⋆⁺₊⋆")
                    sopia.send(rtn);
                }
            }
        }
            {
                if ( e.cmd === "현재곡"){
                    if( cmd === "현재곡"){
                    if( cmd === "현재곡"){
                        if( sopia.var.songReq.length === 0){
                            sopia.send("현재곡은 잘 모르겠습니다.");
                        }else
                        {
                    const now = sopia.var.songReq[0];
                    sopia.send(`현재곡은 ${now}입니다.`);
                        }
                    }
                }
            }
        }``
        if ( e.cmd === "신청곡" ) {
            if ( cmd === "신청곡" ) {
                if ( cmd === "신청곡" ) {
                if ( sopia.var.songReq.length === 0 ) {
                    sopia.send("현재 신청곡이 없습니다.");
                } else {
                    let rtn = "";
                    sopia.var.songReq.forEach((s, idx) => {
                        rtn += `${parseInt(idx,10)+1}. ${s}`;
                        if ( idx < sopia.var.songReq.length - 1 ) {
                            rtn += '\n';
                        }
                    });
                    sopia.debug(rtn);
                    sopia.send("ფ 신청곡 ⋆⁺₊⋆")
                    sopia.send(rtn);
                    }
                }
            }  else {
                const song = cmd.replace("신청곡 ", "");
                if ( song.match(/^(제거|삭제)/) ) {
                    if ( song.match(/^(제거|삭제)\ +[0-9]+/) ) {
                        const num = parseInt(song.match(/[0-9]+/)[0], 10);
                        const deleted = sopia.var.songReq.splice(num-1, 1);
                    } else {
                        const deleted = sopia.var.songReq.shift();
                    }
                } else if(song.match(/^(예약)/)){
                    if ( song.match(/^(예약)\ +[0-9]+/) ) {
                    const num2 = parseInt(song.match(/[0-9]+/)[0], 10);
                    const song3 = song.replace(/예약\+ [0-9]+/, "");
                    const middle = sopia.var.songReq.splice(num2-1, 1,song3);
                    }
                }else if(song.match(/^(우선예약)/) ) {
                        const song2 = song.replace("우선예약","");
                        sopia.var.songReq.unshift(song2);
                } else if(song.match(/^(전체삭제)/) ) {
                        sopia.var.songReq.splice(0, sopia.var.songReq.length);
                } else if(song.match(/^(라삭)/) ) {
                     const deleted = sopia.var.songReq.pop();
                }
                else {
                    sopia.var.songReq.push(song);
                }
            }
        }
    }
});