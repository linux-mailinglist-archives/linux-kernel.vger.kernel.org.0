Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC71F27F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 08:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfKGHQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 02:16:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:49786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726498AbfKGHQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:16:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6981AD85;
        Thu,  7 Nov 2019 07:16:50 +0000 (UTC)
Subject: Re: [RFC 00/11] ARM: Realtek RTD1195/RTD1295 SoC info
To:     linux-realtek-soc@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191103013645.9856-1-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <d0b5e4ce-b0f1-2675-c5be-6720140077b8@suse.de>
Date:   Thu, 7 Nov 2019 08:16:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191103013645.9856-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.11.19 um 02:36 schrieb Andreas Färber:
> Prepared but not included here is:
> * RTD1395 family, which we don't have a DT for yet,
> * RTD1619 family, which we don't have a DT for yet, Chip ID to be verified,
> * RTD1319 family, which we don't have a DT for yet, with TODO for its Chip ID.
> 
> Latest experimental patches at:
> https://github.com/afaerber/linux/commits/rtd1295-next

For anyone wondering, the RTD1395 SoC info patch in above tree had a
typo in the chip id that has been fixed and tested on BPi-M4 now.

Cheers,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
