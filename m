Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F63FDF35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 14:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfKONpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 08:45:05 -0500
Received: from pietrobattiston.it ([92.243.7.39]:52156 "EHLO
        jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727249AbfKONpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:45:05 -0500
Received: from amalgama (unknown [IPv6:2a02:578:85b0:500:6544:6148:b2c5:4b58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: giovanni)
        by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id 78F87E1E85;
        Fri, 15 Nov 2019 14:45:00 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by amalgama (Postfix) with ESMTP id BC2C63C100C;
        Fri, 15 Nov 2019 14:44:59 +0100 (CET)
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191114211408.22123-1-gio@debian.org>
 <20191114213901.GA28532@roeck-us.net> <20191114215154.hze2avicv7pwiksp@pali>
 <7ea74678-59e4-2c23-6744-6d0b2eff0a67@debian.org>
 <20191115112902.yfaoqttsafmilijh@pali>
From:   Giovanni Mascellani <gio@debian.org>
Autocrypt: addr=gio@debian.org; prefer-encrypt=mutual; keydata=
 mQINBEuFs48BEACkd+0TjHZ81/gFb0yEsiVhFJ5S3CaAQcFloMQ0PO/CPv4fMpOzL3tfko5Y
 KONBxZGE2NKsRz/z1V/84nzCWMxJdNV/c5hahuoCkCnxmoHkBsSgCzm6QgAc3c+QAZa71oRr
 rJxpH9TyvjMimq1ZNBEVY+vgKCWkkuBqil/UYwn3YVISwlHDSc2amKCA+dtb9EQv8oTJcr7C
 bACH1MqszW0kKNJrAvfkT2vnawhUB0bJeqLGUN8/F+2DDbHfqNPCEOMJY78/Set+m4uvgJyN
 btZ7fa6FSEsk22fT+KxyPVDbEktdECGz3oupYqh7pZSManqEIvDOzHKWgvjo2yCF3dzU/ykZ
 gOIk2AQ3DeSB6llHbHA2/2Ms+RH6eCb8Bx+GJ5Ta5DUNQh3DZyuWR/Doc3NsAoLsaOWHwH+P
 D9ctmP/1ZN5a7mRcj/IKPquTvxHfg81FmS2H84lv1RrgR36QzCMiJHWOgm9UePEk8xlVeG0r
 lZ9yNCikzMkxuIAhlmWEyeZ9RgKOnYKy/9OgELHWsRIsPIkORVkpwz/Rpar0gbxhOisBOVQW
 2f7GvNtJFyeC+xSz4hVIFQAtS/JFXZ+R2/xuhxRY1cK7gQfELioFyXmb9/gPgPjwxjizttUr
 LFB7WH/lwPqA7znjh2si4CNBpgcPUgY8HPjhcFPqZvi/Gf6xSwARAQABiQI3BB8BCAAhBQJL
 hbdXFwyAER62PUPiAU3fZ70AP/ywu1xfH79wAgcAAAoJEJ7cyZHZq0V+4Q8P/ja1ucn2tGwx
 kSHxwpIFDB2k8gMn5McCF6VDKojuPTJQrRLOmpNPyE3CdkS5ki/YQzBQV41X/gslkl6Sc0wS
 9Cvrd2yhydzUesdRHjSjZMk2J0LxguoRj6LQo5cnWOKtrmefAAYUvoRNnEQATw1/LNOec+3x
 rPz5bNtenmT08w0cnJnAQbPypIEn7tiNESEJCQrZ/g0w0u3+ZCOEPS3pOK6wkJLNgKmxwBaa
 Vu0RJwZ7tj0y+9B+lvS1ibZDF+NfQpS7qSrO8Usydx0Lp3sLPBWL0SBRknMj8O57QeOWlLbj
 UWxj5BQMFNVeKdB4F84dWa702scbLOqwMZ7zflge33WzYd86TNgGDmPLqVa5P+o0syPRD4V6
 axTbYA7fJQcCt3OvoBPbPLn2q2XYpO39SOnJPSi7RlnZX0hxbslyLwa1ZUQPCeP0dQXd2R0N
 FlTWQFqiSZEq27dyFvpRuHfNjHbRXaCbpQBQgHRFidJRD40Mf/CcDwLbx1cRdx1mmhMzWEha
 5ELMWGv28DCwUPfoYFWHbHsHRSBtpneID9CmjHYcGlsfXEfA4s5ChEVIyIaoM6n2cSZCK6H5
 t3YloQGIvua7bHxWNL8hu81LskovkWTWMToZZrNH58Iks5/Wq2/YahKiTmR5aTETLzBOwMiS
 0EUMgCGo2bDeLCKk9M4faOX2iQI3BB8BCAAhBQJLhbd9FwyAERJtr2vMhNfQXWpMmnGVbUfN
 m5gGAgcAAAoJEJ7cyZHZq0V+b2IP/1ptoR3enOCxcr+qv6e5+JAPZJtZpUQUyd6eE9/avCaV
 cvnIoogDX+OPlqUZMqbhlBmFt7Wo6cl9NTbDqc0WuOL94rRT7umbOoIkebIam/PxiG1WfLgZ
 teIPtElrZ9T0u797ZdIpfyR/BxeONHKQwja7MrcezA6I7ozSWTTVRetF7cBhFYGreZewNuxp
 XhfH7gPpS5l04+CGBseUyj5p6rv2ZXihSalrAen3bCIA0VO52OMaIJTCKtDoxcH4psGPX70A
 HyYE0t6rVmddreTx29Y7FqUeh+1bB3Ix1m+wJdv4t/IcrYN0vk4mp3XrcM7EtYBgK34qfJA8
 g/e8UTPqcpFnUHWQYH0smEXlYOGyIFQJERYTOASDSHStoA7hJ3ihM1OYQw6Z/c9RTW5bjvLZ
 ZewGyQDPzK7dTHZL5gI1yro/rQiPK0SwJuBBJRznSPpTEC3ydq9USqiNHvcqAwn/T7vKQWqi
 Si9sIDq8yrcQjaE32F/k4OBBJXqdiw/i+Y0mdXNzHbnYtF03jGwH+ugTXTCVkmNAkN0kKFBe
 fFiTq3ge198I2zYlAUiBpbmUUum1PqqiuPyns8QNN32+z7Yzcfrqj5pYW2b36rn1bltSxALg
 lNk5HXTPdMg34YILQnZEP41rBb0WYAS3uImNJO7m/liMuvVlCs9BLS9sNeAj105qiQI3BB8B
 CAAhBQJLhbeLFwyAEf/OzaK5MM16wngPLTvEI++O2uZPAgcAAAoJEJ7cyZHZq0V+y4QP+wea
 QO85CMD3a2g4Emp7Zzccebz/ku9HecvGdIdForTiyXBkO4lZPxx1QuQ2LO0xOJQ3T9nvkrJL
 1uYJU0hiOkb67E9KDNX0vbZuW8EPzpoAQrJy8aQg8LKcIq4H/tJZTqkssILxF2XJpTLGhSxv
 5VvAgfN5M9LFXQrEtBsrD1s3zNtnf6HT9JkQ+w0mjgaerRgXxxIS6kQGGt0N6veSrseWWiYE
 vC7YSuMvsVTGhB6lzazDMEiQtwZ39/o3dsFwsTiVCoeg6Jb7TMjvsUkdkI59U6irj3H54F0h
 jIaPK+58g6enBBfjjtGJnPU6pWGit4+JZHev90LaozpMFdigO/z4LPDSQ6fpAXwOwXcgAjnk
 vvQrzvTaBJ5W7D3kNzzKEttTFmA6uzWNVlnwvZ6HbPiY0uFr2ENC8LtN5zOmlnRXU3tQo8d9
 xpJA8q2Zm0NXOP90nmr9N/tIc9YypOHWqfW+QRACT8oifqb0JjGRgoo2pbs8VUvl4+v/BRsh
 NpdgrkiSpHpgcHfejAJp0egPPTs6oiyCQETauv641cIg52f0PSmt1kNSUfmKVKg9rdtwbdts
 Ec6v1s1gbKdQgi0NT4AnwebhzY0Zg92s8FXXdnLLVEBiUaLArODsIJxdtqebFi0R01fDM+WD
 PP5GSAfaH1QfssvoFyKvX4MCMKC/9K0SiQI3BB8BCAAhBQJLhbeZFwyAEWnqcI6mvyLOVRvw
 AK6GEjHf1YHFAgcAAAoJEJ7cyZHZq0V+U2gP/38gxOQTHSNoq2z70fIcje/1DLqGTCnd3h0a
 TzChha1QjN6gRGJmX5Jk/mJ87WqUzpc6tKrlxLny4xqWMo4Y6EhvJ0xfxK7QAmFiuZ5DgYO0
 d1FLTBuNQaLj91fAn1HO3yRl3MYh5H5Glw+ntv9hmaziN3cBSZ9NebNG5T/SpINpCkUhNXvS
 NdcPcCGruix1Rpz6nZInU95uhUVFjsYntRDP+8dABN6TkNPbU/ztfPTxYlMpViI4gaPr/xXI
 SIGkWaM5kRA2zB+EeStRn2ITnI2Zlw7s7i1zqNiE/LUHHeLvurXm0tl+HbzwZz0kWJcxkFT0
 sdfrdqizT5g0A5VZPnE+AFPkNfNgwEDaKaCm4gTTx48/WeYDGIPllp1vMDdWr2k8wfBQqxFX
 /xk49rToXTtBi5lyDc3WbPnzktEp1TdRQ3BSBxHDdH45NSlg1LAdRTTgvhJiJRJySy+i+Ri/
 jMqnyXPKOWEioTvOHzVpdlO5zd1+6VIdXC5+/8aHeK4xJYuTPG2IYHE58GSEk9HpGl0Q75TF
 6Sq7c+3hwOTwhCH7Cl8nVh0dTuyXsaT2zUWo5sHEKPD0emVSevnC0Ce/yxCot7g3NtC8LF14
 RBw+6/HRU1eNUAD23P+H2SDh3joF4zNyJXuLL6RdboKg2lS4FsbBweJH+Xfg3wFtMODpjJT7
 tCRHaW92YW5uaSBNYXNjZWxsYW5pIDxnaW9AZGViaWFuLm9yZz6JAlcEEwEKAEECGwMCHgEC
 F4ACGQEFCRMadQIWIQSC0RmoQMbvym9a+UWe3MmR2atFfgUCXUacGQULCQgHAwUVCgkICwUW
 AgMBAAAKCRCe3MmR2atFfiqMEACGnHwsHSvFUTgCs8LdL5tOYwfglpTzSBr+p9HJqG7RoP2x
 k+y/uvehA/OPJvaY2VlW++Hu32EkBwZPhH0FKSLm2W/w7wgwa9723UBKxOI+G2xAtW4TXAvD
 A7MnF93CuXkf/qow65phOdmvVe+hWl2MbColPojOMv4Z4lEXVV1pouFcVHNd3EqkLUK90ZOe
 9afjkdxaY62ahu/ghOLrNkC2latCqJbHJzsdT/4SO0fmSVistaesHasAtl67YO+sEljTXPE1
 tjZT8+lZKzSE2T387sPmxjOcRrzH6ItZF6MSoJr4M41OZG8sR/Jb0yRuYk3QYQuKeou1LO7G
 SydAFN9Ax7I9Lwo4/YMKqNzpxcA32VSdvjCi8KiktfYo7LiiOgbwQTH9ip/b3CxUb8U6OSSG
 hcRbt5Xwd/pGGWnkEhOBlxD6AkOiclGqYaTJomQAR0R7JGW66NUUsKyP6HYFyuvt+4hriM9B
 iWcLWTymdSNvIr+6XUYh8cAXS+rmiIBFsbp5EZK3WJWg1kWK3HCBrgXA2h8oCv7sESLxBIXJ
 7ndhBaOIGl+H66za/VRp1LipJU6DRuPfKlbTgGxTreP9F9J00K2WoItiiiybKeyZXHTtb/o4
 XFKGfUKbKAGM3hCWY9Xk6j2LsTUJ+y2UQcnC+RywxuwfQPHK3ucEnTI5edxfULgzBFYehXcW
 CSsGAQQB2kcPAQEHQHCFeb5U0IJ2MFpJMErA7LAQauRL7ykTaVwtMVniEZKWiQJ/BBgBCgAJ
 BQJWHoV3AhsCAGoJEJ7cyZHZq0V+XyAEGRYKAAYFAlYehXcACgkQja/BDM/eeEl+ZgEA4lQ6
 hQWX3F8U8p1vpkGtXJ28y/RGlhXGmVquzW3EVXIBAK0pNh2oIIZ+BRwLYW4+XdQaKXgUBFiI
 WuYCnCSKI80BzJoP/1BjbPKrCezoErfQnIzXCGvNXsm80UJtzDJQRvaW5wyDCbik7v/3mnUs
 Uz2MW42H4BBb+NKxXjTwgxyPowOehhORtPLvgBpBiTcDeQrAILcbDJHvSqn3WoEInJ7U5PsB
 NCXZBLbE9my0MsOUR6bwh48UD/kO+JljrwVm3kvRdPNgJXTNNXmuQz9I2R/awaq5bKlIowu5
 r6iqGQvh+5Ps/OKlhSCHBUEf9Gwb03tTL+dBC2BRcDgk0yHud1jgkJZSK5PiHjrTK3BIHxLJ
 nqi62tBBOUKJGf6d0UGiJ7C99X+BuBvwxIHU/kb/c0HhA/4f4ms9icu8BUX5/4837ybPn9cP
 lDrM7F86oUnxakTw86OYd3+wJe1D4yv6jq2J/ATDLIwe5gxIloMaaMn+Ycrzt+RNHaTWE/3Y
 S8KHe2tXaYI6WA0XdHZUY/6sUQIMmgsiG+O9atk8pDuiWBjJ16HDKMRUNdRHPlsV7iIe4Jf5
 OVVNmWA/OpVSU6Mc0jP/c0OqmtnkfrsKMfUiT7OMpH+xxeMGg1n50aTJAomWwcJRnGRotkys
 zM56HO5ZzXDg3RQjIcIRNhpy1TEcErKWzqI6WZEiFfk3dcBXgKUVkKzuT/pMrB9Xuwrkwc3Z
 NeqGQPngX2fIEfOM7kWIQSArO2U0CavJ6qWnwppqnPRAzRWWrXCKuDgEWwhMXhIKKwYBBAGX
 VQEFAQEHQPioGZ1v3aR1AHcZGKZ/zQnKxWB33VSmRCcIF1mLpPk7AwEIB4kCNgQYAQoAIBYh
 BILRGahAxu/Kb1r5RZ7cyZHZq0V+BQJbCExeAhsMAAoJEJ7cyZHZq0V+lN8P/2CAMzMOB4h+
 YaOPR5l8OwE0UAGe+KqC6Eqtrwb1LbUthDcXcJm6EO1SD705P0Aj8fhi0SYZ1SjSF7CzgK/F
 sMzfxAwd50c3qsD3rfvvgyc/1ymN3tNmtu5p2iPnD+ZPfAijTBlBTpyjg6LJXDWVFoBnjrcp
 s0Hf14LQxYXSAageh6tuxNfxjuxTAkFYSXNia+szkxV8AiVE7MwEB/W/TAMhf33r1Wm7MUil
 2+iVmq8PCqnFWkDDRutVQWOJCw7D6p8mACss+BD1zN+/dMLtlsP0NdBiNGw2OeXi8Ec/RVWG
 VB6qOCHSoIowyd+PnQSJJLFeBorEpSi8UmcFiIQvzLDnG7lB3E62STmCh1BlQqQKGRx1hBQU
 nX+DgAGTjIqIB0U9V3YbDTmNRcJNZxgXJRL5zVqVdA+JdTy0fFz186wgwVf8d5XThFR4J1ly
 Pi3qViBEeX5MZ+Z6jv/SmQEeh+gh9rXK78IhonFRu7RenvMem2gPyaeW6iCqjeMpSHf2cisM
 udzog6eDzWEtw0JciPPM71qT9oA9dCz88zpqI5CMhWx2kBs22I5f0UpnzLdP6nBinDQSGZMY
 XRbSaA8z+zlgPDPe+KWg8b1ekx4jks6bzOJJTABo/ybdjLkky4iKg1cqmlKn+zH6z2K5lmc3
 uq3/WmRPv8r10mXRkWvDuXvi
Organization: Debian
Message-ID: <97d17b37-0267-ae32-803c-ce8f7a871ab4@debian.org>
Date:   Fri, 15 Nov 2019 14:44:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191115112902.yfaoqttsafmilijh@pali>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NyVn9R6Bve061IMhGxQ7zejB181H4YCHA"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NyVn9R6Bve061IMhGxQ7zejB181H4YCHA
Content-Type: multipart/mixed; boundary="ZyPZV5BvejC6SkRgRQ062JTBm8Pi9flLf";
 protected-headers="v1"
From: Giovanni Mascellani <gio@debian.org>
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <97d17b37-0267-ae32-803c-ce8f7a871ab4@debian.org>
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
References: <20191114211408.22123-1-gio@debian.org>
 <20191114213901.GA28532@roeck-us.net> <20191114215154.hze2avicv7pwiksp@pali>
 <7ea74678-59e4-2c23-6744-6d0b2eff0a67@debian.org>
 <20191115112902.yfaoqttsafmilijh@pali>
In-Reply-To: <20191115112902.yfaoqttsafmilijh@pali>

--ZyPZV5BvejC6SkRgRQ062JTBm8Pi9flLf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Il 15/11/19 12:29, Pali Roh=C3=A1r ha scritto:
> No. I have not tested that my patch on other models. You can look at
> that my patch link, some people already reported that on some models it=

> does not work...

Yes, I saw that. But they are also using other laptops, which could be
excluded by the whitelist until we have a working command for them.

> What is incompatible with Secure Boot? sys_iopl nor sys_ioperm has
> nothing to do with UEFI Secure Boot. They are just ordinary syscalls
> like any other and are executed on kernel side. And IIRC it is up to th=
e
> kernel how it set privileges for I/O ports. Maybe bootloaders under
> Secure Boot can set some other default values, but kernel can overwrite=

> them. I really do not see reason why it could be incompatible with UEFI=

> Secure Boot nor why it should not work. It just looks like improper
> setup from userspace.

Ah, my fault here: there is a patch to lock down the kernel when it is
started with Secure Boot[1], and I believed that was already in
mainline, but apparently it is not.

 [1]
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/com=
mit?id=3D160a99536afc317b337212dd40eaba341702343e

> It makes sense to have implemented in kernel switching between automati=
c
> and manual mode as kernel has API for it. But it depends on the fact
> that we know which SMM API to call. And currently it is just some rando=
m
> call which we somehow observed that is working on 2 machines and on som=
e
> more other does not. Until we have fully working implementation we
> cannot put it into kernel.

Mmh, but then what is a plausible way forward to have this? Can't we
start populating a whitelist for the machines we already have a solution
for, and add more entries when they are discovered? This would already
give a benefit to the users of supported laptops, without impacting
users of unsupported laptops. My feeling is that if we pretend to have
information for all possible models supported by dell-smm-hwmon, we will
never benefit any user. Or can you suggest a plan?

> What does not make sense for me is to have that "protection" in kernel.=


I am not really sure which "protection" you mean. I didn't mean to
introduce any protection from userspace in my patch, I just wanted to
make SET_FAN working. I think that the kernel module cannot (and should
not) reliably protect itself from userspace sending random IO port
reads/writes.

Thanks, Giovanni.
--=20
Giovanni Mascellani <g.mascellani@gmail.com>
Postdoc researcher - Universit=C3=A9 Libre de Bruxelles


--ZyPZV5BvejC6SkRgRQ062JTBm8Pi9flLf--

--NyVn9R6Bve061IMhGxQ7zejB181H4YCHA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSiBF6hBvCQNcghJEaNr8EMz954SQUCXc6r2wAKCRCNr8EMz954
STCwAP9AC/fk2/5N4a7sP8gY3XVFZVzI7YLey0vldVD6ggKyMQD8CY1JvljcqQcL
7Jz0/9BeepujfZ+uzZxhqyTTcSf6igo=
=J/6k
-----END PGP SIGNATURE-----

--NyVn9R6Bve061IMhGxQ7zejB181H4YCHA--
