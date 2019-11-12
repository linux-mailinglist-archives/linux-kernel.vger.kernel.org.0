Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0EF880B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 06:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfKLFfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 00:35:14 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:56375 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:35:13 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xAC5Ys5B044691;
        Tue, 12 Nov 2019 14:34:54 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Tue, 12 Nov 2019 14:34:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xAC5YsTp044685
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 12 Nov 2019 14:34:54 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add analog audio nodes on
 rk3399-rockpro64
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
References: <20190907174833.19957-1-katsuhiro@katsuster.net>
 <CA+E=qVdvKxzFcU-09Ucn1Fr0FdkwSsPcLr8vPn2wsu6-DD1gqg@mail.gmail.com>
 <abc648cc-0b5d-b407-b74b-639833ba196b@katsuster.net>
 <CA+E=qVdy-wqmR+XOms5S2zMp+B0vM7Dj_fk9N=08-1WjfKDm0Q@mail.gmail.com>
 <CA+E=qVdLzHbNTemMSmhA=-0dsNumQZJhjE-EnXBDu+j7sXTnVw@mail.gmail.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <81666aeb-f3d0-e653-6597-0711a05f9b8d@katsuster.net>
Date:   Tue, 12 Nov 2019 14:34:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CA+E=qVdLzHbNTemMSmhA=-0dsNumQZJhjE-EnXBDu+j7sXTnVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vasily,

Thank you for valuable information.

On 2019/11/12 4:25, Vasily Khoruzhick wrote:
> On Sun, Nov 10, 2019 at 9:40 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>
>> On Sun, Nov 10, 2019 at 7:30 PM Katsuhiro Suzuki
>> <katsuhiro@katsuster.net> wrote:
>>>
>>> Hello Vasily,
>>
>> Hi Katsuhiro,
>>
>> Thanks for response!
> 
> Looks like on my board codec sits at address 0x10, and according to
> schematics that's what its address is supposed to be.
> 
> See http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> 
> Codec address is selected by pin CE of ES8316, and on rockpro64 it
> goes to GND through R226. So address should be 0x10.
> 

Yes, I agree. The schematics both v2.0 and v2.1 say that ES8316
address is 0x10. Thank you for pointing.

But I wonder that my RockPro64 behavior is strange, he is in address
0x11. (R226 on my board is broken...??)

root@rockpro64:~# i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

I plan to check R226 resistance value to judge R226 is broken or not
after return to home. And share the result with you.
Please give me a time.

Best Regards,
Katsuhiro Suzuki


>>> Thank you for reporting.
>>>
>>> On 2019/11/11 9:17, Vasily Khoruzhick wrote:
>>>> On Sat, Sep 7, 2019 at 10:48 AM Katsuhiro Suzuki
>>>> <katsuhiro@katsuster.net> wrote:
>>>>>
>>>>> This patch adds audio codec (Everest ES8316) and I2S audio nodes for
>>>>> RK3399 RockPro64.
>>>>
>>>> Hi Katsuhiro,
>>>>
>>>> I tested your patch with my rockpro64 on 5.4-rc6 which has your other
>>>> patches to es8316 driver, but apparently it doesn't work.
>>>>
>>>> 'alsamixer' complains 'cannot load mixer controls: No such device or
>>>> address' and if I try to play audio with mpg123 it pretends that it
>>>> plays something but there's no sound.
>>>>
>>>> Any idea what can be wrong?
>>>>
>>>
>>> Do you use defconfig? If so I guess we need turn on more configs:
>>>
>>> - simple-graph-card driver (CONFIG_SND_AUDIO_GRAPH_CARD)
>>> - ES8316 (SND_SOC_ES8316)
>>
>> I have these enabled, card is present in /proc/asound/cards, but
>> alsamixer doesn't work with it.
>>
>>> FYI) ASoC related status or logs in my environment as follows:
>>>
>>> root@rockpro64:~# uname -a
>>> Linux rockpro64 5.4.0-rc6-next-20191108 #169 SMP PREEMPT Mon Nov 11 12:21:44 JST 2019 aarch64 GNU/Linux
>>
>> I'm running 5.4.0-rc6  (commit
>> 00aff6836241ae5654895dcea10e6d4fc5878ca6) with your patch "arm64: dts:
>> rockchip: add analog audio nodes on rk3399-rockpro64" on top of it.
>>
>>> root@rockpro64:~# dmesg | grep -i asoc
>>> [   21.509903] asoc-simple-card hdmi-sound: i2s-hifi <-> ff8a0000.i2s mapping ok
>>> [   21.510550] asoc-simple-card hdmi-sound: ASoC: no DMI vendor name!
>>> [   21.567906] asoc-audio-graph-card sound: ES8316 HiFi <-> ff890000.i2s mapping ok
>>> [   21.568565] asoc-audio-graph-card sound: ASoC: no DMI vendor name!
>>
>> Similar here:
>>
>> [vasilykh@rockpro64 ~]$ dmesg | grep -i asoc
>> [   15.627685] asoc-audio-graph-card sound: ES8316 HiFi <->
>> ff890000.i2s mapping ok
>> [   16.250196] asoc-simple-card hdmi-sound: i2s-hifi <-> ff8a0000.i2s mapping ok
>>
>>> root@rockpro64:~# cat /proc/asound/pcm
>>> 00-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi i2s-hifi-0 : playback 1
>>> 01-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : playback 1 : capture 1
>>
>> Same here:
>>
>> [vasilykh@rockpro64 ~]$ cat /proc/asound/pcm
>> 00-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : ff890000.i2s-ES8316
>> HiFi ES8316 HiFi-0 : playback 1 : capture 1
>> 01-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi
>> i2s-hifi-0 : playback
>>
>>> root@rockpro64:~# cat /sys/kernel/debug/asoc/components
>>> hdmi-audio-codec.3.auto
>>> ff8a0000.i2s
>>> ff8a0000.i2s
>>> ff890000.i2s
>>> ff890000.i2s
>>> ff880000.i2s
>>> ff880000.i2s
>>> es8316.1-0011
>>> snd-soc-dummy
>>> snd-soc-dummy
>>
>> Same here.
>>
>>> root@rockpro64:~# cat /sys/kernel/debug/asoc/dais
>>> i2s-hifi
>>> ff8a0000.i2s
>>> ff890000.i2s
>>> ff880000.i2s
>>> ES8316 HiFi
>>> snd-soc-dummy-dai
>>
>> Same here.
>>
>> Yet alsamixer doesn't work for me. It terminates with 'cannot load
>> mixer controls: No such device or address'. Strace shows that fails
>> here:
>>
>> openat(AT_FDCWD, "/dev/snd/controlC0", O_RDWR|O_CLOEXEC) = 3
>> fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
>> ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xfffffd3ad04c) = 0
>> fcntl(3, F_GETFL)                       = 0x20002 (flags O_RDWR|O_LARGEFILE)
>> fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK|O_LARGEFILE) = 0
>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) = 0
>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) = 0
>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_INFO, 0xfffffd3ace38) = 0
>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_READ, 0xfffffd3ac160) = -1 ENXIO (No
>> such device or address)
>>
>> Looks like it fails to talk to the codec?
>>
>> mpg123 thinks that it's playing audio, but my headphones connected to
>> 3.5mm output are silent.
>>
>> Regards,
>> Vasily
>>
>>
>>> Best Regards,
>>> Katsuhiro Suzuki
>>>
>>>
>>>> Regards,
>>>> Vasily
>>>>
>>>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>>>> ---
>>>>>    .../boot/dts/rockchip/rk3399-rockpro64.dts    | 28 +++++++++++++++++++
>>>>>    1 file changed, 28 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>> index 0401d4ec1f45..8b1e6382b140 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>> @@ -81,6 +81,12 @@
>>>>>                   reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
>>>>>           };
>>>>>
>>>>> +       sound {
>>>>> +               compatible = "audio-graph-card";
>>>>> +               label = "rockchip,rk3399";
>>>>> +               dais = <&i2s1_p0>;
>>>>> +       };
>>>>> +
>>>>>           vcc12v_dcin: vcc12v-dcin {
>>>>>                   compatible = "regulator-fixed";
>>>>>                   regulator-name = "vcc12v_dcin";
>>>>> @@ -470,6 +476,20 @@
>>>>>           i2c-scl-rising-time-ns = <300>;
>>>>>           i2c-scl-falling-time-ns = <15>;
>>>>>           status = "okay";
>>>>> +
>>>>> +       es8316: codec@11 {
>>>>> +               compatible = "everest,es8316";
>>>>> +               reg = <0x11>;
>>>>> +               clocks = <&cru SCLK_I2S_8CH_OUT>;
>>>>> +               clock-names = "mclk";
>>>>> +               #sound-dai-cells = <0>;
>>>>> +
>>>>> +               port {
>>>>> +                       es8316_p0_0: endpoint {
>>>>> +                               remote-endpoint = <&i2s1_p0_0>;
>>>>> +                       };
>>>>> +               };
>>>>> +       };
>>>>>    };
>>>>>
>>>>>    &i2c3 {
>>>>> @@ -505,6 +525,14 @@
>>>>>           rockchip,playback-channels = <2>;
>>>>>           rockchip,capture-channels = <2>;
>>>>>           status = "okay";
>>>>> +
>>>>> +       i2s1_p0: port {
>>>>> +               i2s1_p0_0: endpoint {
>>>>> +                       dai-format = "i2s";
>>>>> +                       mclk-fs = <256>;
>>>>> +                       remote-endpoint = <&es8316_p0_0>;
>>>>> +               };
>>>>> +       };
>>>>>    };
>>>>>
>>>>>    &i2s2 {
>>>>> --
>>>>> 2.23.0.rc1
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>
> 

