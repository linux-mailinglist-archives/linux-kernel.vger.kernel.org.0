Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6ED1400FC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 01:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgAQAcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 19:32:06 -0500
Received: from mail.prewas.sk ([212.5.209.170]:49349 "EHLO mail.prewas.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbgAQAcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:32:05 -0500
dkim-signature: v=1; a=rsa-sha256; d=3ksolutions.sk; s=mail.prewas.sk;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=/ufg4YOpQeSX7cHfO6yjVhqqe1zoV2RAyfuHFpGADIk=;
        b=TkBU61dQOLsmC1C6opABH7EfcFHApUscqlJRZ39KvqiJMLdBy9gZAcE1Jim9nPqJMBop8CDciT17nbvKUTjAaPGQVBkeOAcNkSm2lF5k7G9hD+S96I29nZtl+3XbufAcC2vuyJQAxQvUkqZOYv4ApGF9pySPSF6LJ94NhTgQs3uGkjAjuQ5qt9+dyyWBGsO8ehklAECOExbDLkIy7E3NuzSGzh93eZT8oP7mkDGdy/JuhapHCOVtnG6+N1
        /rt7Q4IOKZLWWek0HAN6zJdQPny+zwD9TRd4pedc4+q++gVvCOqeoZWij0TIOsocFbnihgdfGmaXp3YF/kfLKe6Ghb2w==
Received: from [10.0.1.61] (pcfilo.vital.sk [10.0.1.61])
        by mail.prewas.sk with ESMTPSA
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128)
        ; Fri, 17 Jan 2020 01:31:48 +0100
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20200106235203.27256-1-sistik@3ksolutions.sk>
 <20200107072748.GA1014453@kroah.com>
From:   "Ivan Sistik - 3K Solutions, s. r. o." <sistik@3ksolutions.sk>
Message-ID: <f6deeb06-39b7-f140-c6bd-c977c5ad2b5a@3ksolutions.sk>
Date:   Fri, 17 Jan 2020 01:31:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107072748.GA1014453@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7. 1. 2020 at 8:27 Greg Kroah-Hartman wrote:

>> +config SERIAL_AMBA_PL011_SOFT_RS485
>> +	bool "RS485 software direction switching for ARM AMBA PL011 serial"
>> +	depends on SERIAL_AMBA_PL011=y
> 
> Why "=y" here?  Shouldn't this just read:
> 	depends on SERIAL_AMBA_PL011?
> 
>> +	select SERIAL_CORE
> 
> Is this needed?  SERIAL_AMBA_PL011 already selects this.

I am not sure. I found this few lines above:

> config SERIAL_AMBA_PL010_CONSOLE
> 	bool "Support for console on AMBA serial port"
> 	depends on SERIAL_AMBA_PL010=y
> 	select SERIAL_CORE_CONSOLE

and modified it for my purpose.


Thanks,

Ivan

