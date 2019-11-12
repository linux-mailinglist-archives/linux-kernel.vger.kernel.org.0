Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302AAF8837
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 06:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLFt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 00:49:57 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39145 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLFt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:49:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id v138so13739787oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7OGsdO2VbLEy7022hu/ffUq8d11VfcJnuAfwqP4bjw=;
        b=GmZ05pZVFWQYw5Cc7rmmqJEXJiVOGEiN7mjBfcE+5JrwhMU4SZDuIDs5VyLHG4HsdC
         ip5ONqRF27d43gnq0F/m375dkDOypulgy0ZD2AKWWFReOUdq4DUV2eAK5FFizL7J1zrr
         M8dxD5p3Q/WZqv6VGhze98DyPKYLCC5SPdv+XFWuMKaqy7rd/OXmQX5+7cPpNqDzNS5A
         zlCgd0P6WI+UjkaAXlI/0E3w7Adn0aczIZ/JqRzYeGlZOaTf7Tv5fvhfAZYBIYBY6X8Y
         dMvLP3YXPrsjPJvfoSerAO/AE7Yd/9kK/DWFRWyNjENeX3g8jnbWVbuwt+TcUBWYQwoA
         /mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7OGsdO2VbLEy7022hu/ffUq8d11VfcJnuAfwqP4bjw=;
        b=hiIB0t9vs0r6ogZXQfhNyD2quD5O0cTpqmqSnCmLNPuCopDpKg0alREr9WN+ytksRd
         t+UZnejwqFDP5sX/kqrFrjdYXadILX5Y9/BK3a7ywI+XmW2qL5DXI2FaRpKLvAXC6SR5
         Bj7YqXzrdHt3E3AOSwnwfx7GSIxyGxPuMPz716clff6+f8EQthC+/tDIP3iFwPvezuee
         NmAXTL+r2QlHnL+AXpTUNIP3eR01BsQyNDpipBuKGlqMvCVB+XsI4c3ZyRVebeVTmxrN
         GZ91GNUJdIFBmNgY3vQRxCASruhqMDyCeEQvZtixEtjkYrrkmDOhUnoPjcaeBKVg4qNk
         a8Ow==
X-Gm-Message-State: APjAAAXcaxqF2jvMkmIr6Jm05RRNRsn5ODOoQ1fC7DPgUySyY15Mc8z9
        O6MBDjGUixRmULLF2KVlmpzGvu7gRaATbdLEXk8=
X-Google-Smtp-Source: APXvYqxv8NiTo1l3ovTjO2t2TROPS4E7UMnCTcFUmgnhxHjgD4s94Nba6pIpF6ISkkboTuZeV3xWFXuvTRL4XH8zy+s=
X-Received: by 2002:aca:5e03:: with SMTP id s3mr2535116oib.88.1573537793880;
 Mon, 11 Nov 2019 21:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20190907174833.19957-1-katsuhiro@katsuster.net>
 <CA+E=qVdvKxzFcU-09Ucn1Fr0FdkwSsPcLr8vPn2wsu6-DD1gqg@mail.gmail.com>
 <abc648cc-0b5d-b407-b74b-639833ba196b@katsuster.net> <CA+E=qVdy-wqmR+XOms5S2zMp+B0vM7Dj_fk9N=08-1WjfKDm0Q@mail.gmail.com>
 <CA+E=qVdLzHbNTemMSmhA=-0dsNumQZJhjE-EnXBDu+j7sXTnVw@mail.gmail.com>
 <81666aeb-f3d0-e653-6597-0711a05f9b8d@katsuster.net> <CA+E=qVcgs=2T_9axUCJwTKgmKhjsJJ9mUfvYJbyjg59rGGjcTg@mail.gmail.com>
In-Reply-To: <CA+E=qVcgs=2T_9axUCJwTKgmKhjsJJ9mUfvYJbyjg59rGGjcTg@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Mon, 11 Nov 2019 21:49:28 -0800
Message-ID: <CA+E=qVe5QmJ8-zSbKj23mb-GksjD+qN=aFaCT7OGUYPYc9Y_ow@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add analog audio nodes on rk3399-rockpro64
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 9:43 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Mon, Nov 11, 2019 at 9:34 PM Katsuhiro Suzuki
> <katsuhiro@katsuster.net> wrote:
> >
> > Hello Vasily,
> >
> > Thank you for valuable information.
> >
> > On 2019/11/12 4:25, Vasily Khoruzhick wrote:
> > > On Sun, Nov 10, 2019 at 9:40 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > >>
> > >> On Sun, Nov 10, 2019 at 7:30 PM Katsuhiro Suzuki
> > >> <katsuhiro@katsuster.net> wrote:
> > >>>
> > >>> Hello Vasily,
> > >>
> > >> Hi Katsuhiro,
> > >>
> > >> Thanks for response!
> > >
> > > Looks like on my board codec sits at address 0x10, and according to
> > > schematics that's what its address is supposed to be.
> > >
> > > See http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> > >
> > > Codec address is selected by pin CE of ES8316, and on rockpro64 it
> > > goes to GND through R226. So address should be 0x10.
> > >
> >
> > Yes, I agree. The schematics both v2.0 and v2.1 say that ES8316
> > address is 0x10. Thank you for pointing.
> >
> > But I wonder that my RockPro64 behavior is strange, he is in address
> > 0x11. (R226 on my board is broken...??)
> >
> > root@rockpro64:~# i2cdetect 1
> > WARNING! This program can confuse your I2C bus, cause data loss and worse!
> > I will probe file /dev/i2c-1.
> > I will probe address range 0x03-0x77.
> > Continue? [Y/n] y
> >       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> > 10: -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 70: -- -- -- -- -- -- -- --
> >
> > I plan to check R226 resistance value to judge R226 is broken or not
> > after return to home. And share the result with you.
> > Please give me a time.
>
> Thanks for confirming that on your board it's on address 0x11. I
> checked with some other rockpro64 owners and they have it on 0x10, but
> looks like we have boards with codec on different address in the wild.

Another datapoint is that my board is 2.0. If yours is 2.1 it can be a
difference between 2.0 and 2.1.

> > Best Regards,
> > Katsuhiro Suzuki
> >
> >
> > >>> Thank you for reporting.
> > >>>
> > >>> On 2019/11/11 9:17, Vasily Khoruzhick wrote:
> > >>>> On Sat, Sep 7, 2019 at 10:48 AM Katsuhiro Suzuki
> > >>>> <katsuhiro@katsuster.net> wrote:
> > >>>>>
> > >>>>> This patch adds audio codec (Everest ES8316) and I2S audio nodes for
> > >>>>> RK3399 RockPro64.
> > >>>>
> > >>>> Hi Katsuhiro,
> > >>>>
> > >>>> I tested your patch with my rockpro64 on 5.4-rc6 which has your other
> > >>>> patches to es8316 driver, but apparently it doesn't work.
> > >>>>
> > >>>> 'alsamixer' complains 'cannot load mixer controls: No such device or
> > >>>> address' and if I try to play audio with mpg123 it pretends that it
> > >>>> plays something but there's no sound.
> > >>>>
> > >>>> Any idea what can be wrong?
> > >>>>
> > >>>
> > >>> Do you use defconfig? If so I guess we need turn on more configs:
> > >>>
> > >>> - simple-graph-card driver (CONFIG_SND_AUDIO_GRAPH_CARD)
> > >>> - ES8316 (SND_SOC_ES8316)
> > >>
> > >> I have these enabled, card is present in /proc/asound/cards, but
> > >> alsamixer doesn't work with it.
> > >>
> > >>> FYI) ASoC related status or logs in my environment as follows:
> > >>>
> > >>> root@rockpro64:~# uname -a
> > >>> Linux rockpro64 5.4.0-rc6-next-20191108 #169 SMP PREEMPT Mon Nov 11 12:21:44 JST 2019 aarch64 GNU/Linux
> > >>
> > >> I'm running 5.4.0-rc6  (commit
> > >> 00aff6836241ae5654895dcea10e6d4fc5878ca6) with your patch "arm64: dts:
> > >> rockchip: add analog audio nodes on rk3399-rockpro64" on top of it.
> > >>
> > >>> root@rockpro64:~# dmesg | grep -i asoc
> > >>> [   21.509903] asoc-simple-card hdmi-sound: i2s-hifi <-> ff8a0000.i2s mapping ok
> > >>> [   21.510550] asoc-simple-card hdmi-sound: ASoC: no DMI vendor name!
> > >>> [   21.567906] asoc-audio-graph-card sound: ES8316 HiFi <-> ff890000.i2s mapping ok
> > >>> [   21.568565] asoc-audio-graph-card sound: ASoC: no DMI vendor name!
> > >>
> > >> Similar here:
> > >>
> > >> [vasilykh@rockpro64 ~]$ dmesg | grep -i asoc
> > >> [   15.627685] asoc-audio-graph-card sound: ES8316 HiFi <->
> > >> ff890000.i2s mapping ok
> > >> [   16.250196] asoc-simple-card hdmi-sound: i2s-hifi <-> ff8a0000.i2s mapping ok
> > >>
> > >>> root@rockpro64:~# cat /proc/asound/pcm
> > >>> 00-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi i2s-hifi-0 : playback 1
> > >>> 01-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : playback 1 : capture 1
> > >>
> > >> Same here:
> > >>
> > >> [vasilykh@rockpro64 ~]$ cat /proc/asound/pcm
> > >> 00-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : ff890000.i2s-ES8316
> > >> HiFi ES8316 HiFi-0 : playback 1 : capture 1
> > >> 01-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi
> > >> i2s-hifi-0 : playback
> > >>
> > >>> root@rockpro64:~# cat /sys/kernel/debug/asoc/components
> > >>> hdmi-audio-codec.3.auto
> > >>> ff8a0000.i2s
> > >>> ff8a0000.i2s
> > >>> ff890000.i2s
> > >>> ff890000.i2s
> > >>> ff880000.i2s
> > >>> ff880000.i2s
> > >>> es8316.1-0011
> > >>> snd-soc-dummy
> > >>> snd-soc-dummy
> > >>
> > >> Same here.
> > >>
> > >>> root@rockpro64:~# cat /sys/kernel/debug/asoc/dais
> > >>> i2s-hifi
> > >>> ff8a0000.i2s
> > >>> ff890000.i2s
> > >>> ff880000.i2s
> > >>> ES8316 HiFi
> > >>> snd-soc-dummy-dai
> > >>
> > >> Same here.
> > >>
> > >> Yet alsamixer doesn't work for me. It terminates with 'cannot load
> > >> mixer controls: No such device or address'. Strace shows that fails
> > >> here:
> > >>
> > >> openat(AT_FDCWD, "/dev/snd/controlC0", O_RDWR|O_CLOEXEC) = 3
> > >> fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
> > >> ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xfffffd3ad04c) = 0
> > >> fcntl(3, F_GETFL)                       = 0x20002 (flags O_RDWR|O_LARGEFILE)
> > >> fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK|O_LARGEFILE) = 0
> > >> ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) = 0
> > >> ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) = 0
> > >> ioctl(3, SNDRV_CTL_IOCTL_ELEM_INFO, 0xfffffd3ace38) = 0
> > >> ioctl(3, SNDRV_CTL_IOCTL_ELEM_READ, 0xfffffd3ac160) = -1 ENXIO (No
> > >> such device or address)
> > >>
> > >> Looks like it fails to talk to the codec?
> > >>
> > >> mpg123 thinks that it's playing audio, but my headphones connected to
> > >> 3.5mm output are silent.
> > >>
> > >> Regards,
> > >> Vasily
> > >>
> > >>
> > >>> Best Regards,
> > >>> Katsuhiro Suzuki
> > >>>
> > >>>
> > >>>> Regards,
> > >>>> Vasily
> > >>>>
> > >>>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> > >>>>> ---
> > >>>>>    .../boot/dts/rockchip/rk3399-rockpro64.dts    | 28 +++++++++++++++++++
> > >>>>>    1 file changed, 28 insertions(+)
> > >>>>>
> > >>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> > >>>>> index 0401d4ec1f45..8b1e6382b140 100644
> > >>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> > >>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
> > >>>>> @@ -81,6 +81,12 @@
> > >>>>>                   reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> > >>>>>           };
> > >>>>>
> > >>>>> +       sound {
> > >>>>> +               compatible = "audio-graph-card";
> > >>>>> +               label = "rockchip,rk3399";
> > >>>>> +               dais = <&i2s1_p0>;
> > >>>>> +       };
> > >>>>> +
> > >>>>>           vcc12v_dcin: vcc12v-dcin {
> > >>>>>                   compatible = "regulator-fixed";
> > >>>>>                   regulator-name = "vcc12v_dcin";
> > >>>>> @@ -470,6 +476,20 @@
> > >>>>>           i2c-scl-rising-time-ns = <300>;
> > >>>>>           i2c-scl-falling-time-ns = <15>;
> > >>>>>           status = "okay";
> > >>>>> +
> > >>>>> +       es8316: codec@11 {
> > >>>>> +               compatible = "everest,es8316";
> > >>>>> +               reg = <0x11>;
> > >>>>> +               clocks = <&cru SCLK_I2S_8CH_OUT>;
> > >>>>> +               clock-names = "mclk";
> > >>>>> +               #sound-dai-cells = <0>;
> > >>>>> +
> > >>>>> +               port {
> > >>>>> +                       es8316_p0_0: endpoint {
> > >>>>> +                               remote-endpoint = <&i2s1_p0_0>;
> > >>>>> +                       };
> > >>>>> +               };
> > >>>>> +       };
> > >>>>>    };
> > >>>>>
> > >>>>>    &i2c3 {
> > >>>>> @@ -505,6 +525,14 @@
> > >>>>>           rockchip,playback-channels = <2>;
> > >>>>>           rockchip,capture-channels = <2>;
> > >>>>>           status = "okay";
> > >>>>> +
> > >>>>> +       i2s1_p0: port {
> > >>>>> +               i2s1_p0_0: endpoint {
> > >>>>> +                       dai-format = "i2s";
> > >>>>> +                       mclk-fs = <256>;
> > >>>>> +                       remote-endpoint = <&es8316_p0_0>;
> > >>>>> +               };
> > >>>>> +       };
> > >>>>>    };
> > >>>>>
> > >>>>>    &i2s2 {
> > >>>>> --
> > >>>>> 2.23.0.rc1
> > >>>>>
> > >>>>>
> > >>>>> _______________________________________________
> > >>>>> linux-arm-kernel mailing list
> > >>>>> linux-arm-kernel@lists.infradead.org
> > >>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > >>>>
> > >>>
> > >
> >
