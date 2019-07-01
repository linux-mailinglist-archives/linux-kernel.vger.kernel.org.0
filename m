Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932DA13E6D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfEEIUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 04:20:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39649 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfEEIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 04:20:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so11549121edq.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=JrdctTWipqg+sf2StR/z36/rA+8zuYAt2kGMeaTZIUA=;
        b=GddTkr3AuFwbWVNPI3/18HOqTvd0CCCQgbyMnVBZSrs3+LE4trljYMfiZRsb7YGcQs
         SK7U/kvBiQBzUME5ErOFzaClZ7QjUkPkFxtpAS+8uWKLrlg/Gj8nmvbs+icJP31HhMgW
         3ujGMe11Q6pde8pdp8LqXAVf7EEfoUQC4Rl5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=JrdctTWipqg+sf2StR/z36/rA+8zuYAt2kGMeaTZIUA=;
        b=fG3y8wEcKQThHjtMUpU8dgXaByBOeEYBW7N+aNFwrp7HLrzXjMN+wy6R22++cqrrcb
         Eoly93C7kN4Q8p/0kfzoWQJaIefxA4JbTVhq2eKgJkqdluSMa9dhECJ4gWeQNXXx9mW6
         5qzQFCXJChCmgs6yONd2vwX4mQkbJ181qrcaT13eMtApcAaqSGAkGqMEnnXu0jA7QJNe
         IifDIYx1WOU56tyeHOr3r+An7uZcCJwaxW1HgEDFmWzBuscNplrD5APNSZA2Ja+zBcwS
         qbu4QqYgxZg9ZlhXtcG8brJEUbTeF1J6Hztd2MsoAtA9LPJb0Nqv2VZpHTe6ulzzonGm
         IpoQ==
X-Gm-Message-State: APjAAAXNgCG5RlQ7qqBLSkVe7nRa6VZNc9hhSdHzjtYF1TF9SK7y5j+j
        mBt6jAFskifYbH4GZyaBy6XTjg==
X-Google-Smtp-Source: APXvYqyPq1Ct2FZynDHLlwG+iG9T2ovQJZ2j8FRCHoWr5elB7FWGGu46U4ajmqjmOV6e+v7+928gjg==
X-Received: by 2002:a50:b662:: with SMTP id c31mr19496774ede.252.1557044436825;
        Sun, 05 May 2019 01:20:36 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id m4sm2013260ede.0.2019.05.05.01.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 May 2019 01:20:36 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Victor Bravo <1905@spmblk.com>
CC:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "Chi-Hsien Lin" <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Sun, 05 May 2019 10:20:33 +0200
Message-ID: <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20190504194440.4zcxjrtj2aft3ka4@localhost>
References: <20190504162633.ldrz2nqfocg55grb@localhost>
 <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: PROBLEM: brcmfmac's DMI-based fw file names break built-in fw loader
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 4, 2019 9:44:51 PM Victor Bravo <1905@spmblk.com> wrote:

> On Sat, May 04, 2019 at 09:11:09PM +0200, Arend Van Spriel wrote:
>> + Hans, Luis
>> 
>> On 5/4/2019 6:26 PM, Victor Bravo wrote:
>> > The brcmfmac driver seems to have partially fixed problems which
>> > prevented it to be used in shared system/kernel images for multiple
>> > hardware by trying to load it's <config>.txt as
>> > <config>.<dmi_sys_vendor>.<dmi_product_name>.txt first and then
>> > falling back to <config>.txt. Real-life example:
>> >
>> > brcmfmac mmc1:0001:1: Direct firmware load for 
>> brcm/brcmfmac43340-sdio.ASUSTeK COMPUTER INC.-T100HAN.txt failed with
>> > error -2
>> > brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43340-sdio for chip
>> > BCM43340/2
>> >
>> > Unfortunately this doesn't really help on systems which use static
>> > kernel with firmware blobs (and also text configuration files in case of
>> > brcmfmac) built-in using CONFIG_EXTRA_FIRMWARE, as CONFIG_EXTRA_FIRMWARE
>> > doesn't support spaces in file names - kernel build fails with
>> >
>> > CONFIG_EXTRA_FIRMWARE="brcm/brcmfmac43340-sdio.bin 
>> brcm/brcmfmac43340-sdio.ASUSTeK COMPUTER INC.-T100HAN.txt"
>> >
>> > for obvious reasons. So the only way here is to stay with good old
>> > brcmfmac43340-sdio.txt and support at most one brcmfmac-equipped machine
>> > per kernel image.
>> >
>> > Please consider filtering the DMI strings and replacing spaces and
>> > possibly other invalid characters with underscores, and/or adding module
>> > parameter to allow passing the string from command line (using
>> > brcmfmac.tag=t100 or brcmfmac.board=t100 to make the module load
>> > brcmfmac43340-sdio.t100.txt seems nicer to me, and isn't prone to
>> > breaking when DMI strings change on BIOS update).
>> 
>> The intent of the DMI approach was to avoid end-users from passing module
>> parameters for this. As to fixing DMI string usage patches are welcome.
>
> Well I think I could also provide a patch to fix, this can be easily
> done by adding a string of allowed characters and then replacing
> unknown ones with underscores.
>
>> > My brief grep-based research also suggest that strings retrieved
>> > by dmi_get_system_info() are passed to firmware loader without any
>> > checks for special character, /../ etc. I'm not sure whether this is
>> > considered to be proper & safe use, but if it's not, it may also have
>> > some security implications, as it allows attacker with access to DMI
>> > strings (using root rights/other OS/BIOS/physical access) to mess
>> > with kernel space or secure boot.
>> 
>> Hmm. Attackers with that kind of access can do bad is a gazillion ways.
>
> Agreed. It will be definitely easier to make filenames contain only safe
> characters than to discuss those ways.
>
>> > I would also really appreciate not allowing future brcm (and other)
>> > drivers to leave staging area before they fully support =y.
>> 
>> Define fully support. At the time we moved into the wireless tree (almost a
>> decade ago) we did support =y. As such you could consider the DMI approach a
>> regression, but I find that a bit harsh to say. Hans made a honest attempt
>> and it is something that can be fixed. It can be you providing just that ;-)
>
> Well... I agree that the idea wasn't really complete ;).
>
> As for the patches, I also realized that the txt config file actually
> comes from EFI/BIOS, so it's quite possible that it may differ between
> BIOS versions. So I'm thinking of 3 patches here:
>
>   1) Character filtering as described above.
>
>   2) Adding bios_version next to board_type, and changing load order to
>
>     <config>.<dmi_sys_vendor>.<dmi_product_name>.<dmi_bios_version>.txt
>     <config>.<dmi_sys_vendor>.<dmi_product_name>.txt
>     <config>.txt
>
>   3) Adding command-line parameters to override these on problems.
>
> 1) breaks backward compatibility, but the DMI code seems to be quite
> new so hopefully many people don't rely on it yet.
>
> 2) & 3) are backward compatible.

Actually, the configuration file, or nvram file as we tend to call it, does 
not come from EFI/BIOS. There are a few platforms that have the nvram file 
stored in EFI and it's name is well-defined. It does assume there is only 
one brcmfmac device in the system.

Regards,
Arend


