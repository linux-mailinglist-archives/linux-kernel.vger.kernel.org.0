Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9ADE7F79
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 06:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfJ2FWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 01:22:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbfJ2FWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:22:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40256B41C;
        Tue, 29 Oct 2019 05:22:47 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] arm64: dts: realtek: Add oscillator for RTD129x
To:     linux-realtek-soc@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191020153612.29889-1-afaerber@suse.de>
 <20191020153612.29889-2-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <3222d376-1e35-3bde-d5d6-674edcbc8e3d@suse.de>
Date:   Tue, 29 Oct 2019 06:22:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020153612.29889-2-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.10.19 um 17:36 schrieb Andreas Färber:
> Add 27 MHz oscillator clock node.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v3: New (from previously blocking clk patch series)
>  
>  arch/arm64/boot/dts/realtek/rtd129x.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to linux-realtek.git v5.5/dt64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.5/dt64

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
