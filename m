Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6ED9A006
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfHVT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 15:28:36 -0400
Received: from first.geanix.com ([116.203.34.67]:38000 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfHVT2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:28:36 -0400
Received: from [192.168.8.20] (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 3A9B7370;
        Thu, 22 Aug 2019 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566502098; bh=o0N23vVITz0AcDJVlteTm0d45DuNdQ7fesle34nmy2M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AQGCP9PWjKUmzXyfL+ALCMEjmtrUqyJnWzGTyYpHoXZCurvuNpLwWPeYORkdeJgQl
         A5E6u/EMuTQl5t9ygY7USJwTp567meifDTmVSMViuAmUFvHc7LzS4pNVj4A9H84f4j
         ez1ykp3vbvM/uPadEuzfl48Y4ho037JCZY+fYuZdoxzsQFHl/JQ8hSsPmq3NSMMCcZ
         wwPxvyZMucP/xcUXx9PAIQleGFrDu6+WOSlM4iqeNHNFdMv1ugBSe/72La2iOQcBGi
         ga/OfEkTGLkkBL/G8GtB7CLfIuMrMNHC6IWtgV66U1OpDD3X2EH19HX4f8OGDGSaMO
         qZd9PGfR6KbJA==
Subject: Re: [PATCHv4] tty: n_gsm: add ioctl to map serial device to mux'ed
 tty
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
References: <20190812211243.98686-1-martin@geanix.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Message-ID: <a67bba41-a92a-1b8f-c8f8-25efe3687695@geanix.com>
Date:   Thu, 22 Aug 2019 21:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812211243.98686-1-martin@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Just a friendly "ping" on this patch.

Thanks,
Martin

On 12/08/2019 23.12, Martin Hundebøll wrote:
> Guessing the first tty for a gsm0710 multiplexed serial device is not
> currently possible, which makes it racy to use with multiple modems.
> 
> Add a way to map the physical serial tty to its related mux devices
> using an ioctl.
> 
> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> ---
> 
> Changes since v3:
>   * use __u32 instead of uint32_t
> 
> Changes since v2:
>   * rename IOCTL from GSMIOC_GETBASE to GSMIOC_GETFIRST
>   * return first usable line instead of private control line
>   * return uint32_t instead of int
> 
> Changes since v1:
>   * use put_user() instead of copy_to_user()
>   * add missing opening quote
> 
>   Documentation/driver-api/serial/n_gsm.rst | 11 +++++++++--
>   drivers/tty/n_gsm.c                       |  4 ++++
>   include/uapi/linux/gsmmux.h               |  2 ++
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/serial/n_gsm.rst b/Documentation/driver-api/serial/n_gsm.rst
> index 0ba731ab00b2..286e7ff4d2d9 100644
> --- a/Documentation/driver-api/serial/n_gsm.rst
> +++ b/Documentation/driver-api/serial/n_gsm.rst
> @@ -18,10 +18,13 @@ How to use it
>   2. switch the serial line to using the n_gsm line discipline by using
>      TIOCSETD ioctl,
>   3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl,
> +4. obtain base gsmtty number for the used serial port,
>   
>   Major parts of the initialization program :
>   (a good starting point is util-linux-ng/sys-utils/ldattach.c)::
>   
> +  #include <stdio.h>
> +  #include <stdint.h>
>     #include <linux/gsmmux.h>
>     #include <linux/tty.h>
>     #define DEFAULT_SPEED	B115200
> @@ -30,6 +33,7 @@ Major parts of the initialization program :
>   	int ldisc = N_GSM0710;
>   	struct gsm_config c;
>   	struct termios configuration;
> +	uint32_t first;
>   
>   	/* open the serial port connected to the modem */
>   	fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
> @@ -58,19 +62,22 @@ Major parts of the initialization program :
>   	c.mtu = 127;
>   	/* set the new configuration */
>   	ioctl(fd, GSMIOC_SETCONF, &c);
> +	/* get first gsmtty device node */
> +	ioctl(fd, GSMIOC_GETFIRST, &first);
> +	printf("first muxed line: /dev/gsmtty%i\n", first);
>   
>   	/* and wait for ever to keep the line discipline enabled */
>   	daemon(0,0);
>   	pause();
>   
> -4. use these devices as plain serial ports.
> +5. use these devices as plain serial ports.
>   
>      for example, it's possible:
>   
>      - and to use gnokii to send / receive SMS on ttygsm1
>      - to use ppp to establish a datalink on ttygsm2
>   
> -5. first close all virtual ports before closing the physical port.
> +6. first close all virtual ports before closing the physical port.
>   
>      Note that after closing the physical port the modem is still in multiplexing
>      mode. This may prevent a successful re-opening of the port later. To avoid
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index a60be591f1fc..d30525946892 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2613,6 +2613,7 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
>   {
>   	struct gsm_config c;
>   	struct gsm_mux *gsm = tty->disc_data;
> +	unsigned int base;
>   
>   	switch (cmd) {
>   	case GSMIOC_GETCONF:
> @@ -2624,6 +2625,9 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
>   		if (copy_from_user(&c, (void *)arg, sizeof(c)))
>   			return -EFAULT;
>   		return gsm_config(gsm, &c);
> +	case GSMIOC_GETFIRST:
> +		base = mux_num_to_base(gsm);
> +		return put_user(base + 1, (__u32 __user *)arg);
>   	default:
>   		return n_tty_ioctl_helper(tty, file, cmd, arg);
>   	}
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index 101d3c469acb..cb8693b39cb7 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -37,5 +37,7 @@ struct gsm_netconfig {
>   #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
>   #define GSMIOC_DISABLE_NET     _IO('G', 3)
>   
> +/* get the base tty number for a configured gsmmux tty */
> +#define GSMIOC_GETFIRST		_IOR('G', 4, __u32)
>   
>   #endif
> 
