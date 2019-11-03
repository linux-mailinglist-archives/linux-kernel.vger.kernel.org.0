Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7803EED178
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 02:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfKCBpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 21:45:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:34526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfKCBpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:45:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6090AAD29;
        Sun,  3 Nov 2019 01:45:18 +0000 (UTC)
Subject: Re: [RFC 02/11] soc: Add Realtek chip info driver for RTD1195 and
 RTD1295
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-3-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <1734baae-e529-e51e-145e-c8e1c533523c@suse.de>
Date:   Sun, 3 Nov 2019 02:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191103013645.9856-3-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.11.19 um 02:36 schrieb Andreas Färber:
>  drivers/soc/Kconfig          |   1 +
>  drivers/soc/Makefile         |   1 +
>  drivers/soc/realtek/Kconfig  |  13 ++++
>  drivers/soc/realtek/Makefile |   2 +
>  drivers/soc/realtek/chip.c   | 164 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 181 insertions(+)
>  create mode 100644 drivers/soc/realtek/Kconfig
>  create mode 100644 drivers/soc/realtek/Makefile
>  create mode 100644 drivers/soc/realtek/chip.c
This patch forgets to add drivers/soc/realtek/ to MAINTAINERS.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
