Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876669D4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 19:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfHZRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 13:18:47 -0400
Received: from rankki.sonarnerd.net ([194.142.149.154]:28812 "EHLO
        mail.sonarnerd.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfHZRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:18:47 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Aug 2019 13:18:46 EDT
Received: from [IPv6:fc00::2] (porkkala.uworld [IPv6:fc00::2])
        by mail.sonarnerd.net (Postfix) with ESMTP id D10372310EC;
        Mon, 26 Aug 2019 20:10:33 +0300 (EEST)
Subject: Re: [PATCH] ALSA: usb-audio: Add Hiby R3 to quirks for native DSD
 support
To:     ilya.pshonkin@netforce.ua
Cc:     Sudokamikaze <sudokamikaze@protonmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Manuel Reinhardt <manuel.rhdt@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190826160953.19402-1-ilya.pshonkin@netforce.ua>
From:   Jussi Laako <jussi@sonarnerd.net>
Message-ID: <021132df-8deb-b9f0-2d9e-e934f92c6c7a@sonarnerd.net>
Date:   Mon, 26 Aug 2019 20:10:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826160953.19402-1-ilya.pshonkin@netforce.ua>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* ESS Sabre based USB DACs */
> +	case USB_ID(0xc502, 0x0051): /* Hiby R3 */
> +		if (fp->altsetting == 4)
> +			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
> +		break;

Do you know who's vendor id is this? ESS Sabre is a DAC chip with I2S 
input, I'm not aware of any product from ESS under Sabre brand that 
would include USB interface. (?) So likely the USB interface is sourced 
from somewhere else...

It is good to check with "lsusb -vvv" if the device flags DSD altsetting 
as raw. Then you know it'll work with the auto-detection code and 
doesn't break so easily if firmware update changes altsettings (not 
uncommon to happen).


	- Jussi

