Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B2F1811E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgCKH2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:28:12 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51845 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCKH2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:28:12 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0672923E74;
        Wed, 11 Mar 2020 08:28:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583911689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSw70fkISSLa6g6Yq0UJ8frDvfTka8uWBM+qhrV4Jkk=;
        b=WwepzPq2B5tgYsgHjvakBFxdsuP/fzodyQIhQ8Gs+QpFwplu4DHBt5cuDihxTWHict4N/Y
        CvnqF/qcVcGsd5oKHJ9cGt6w+bE00SP+p2pEXZ7RrEFKT0xVEP4UCCw6/ghUNsVCTCbsjC
        7vHVlHoHedjfxIN3iGsRVnY1sPOuijI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Mar 2020 08:28:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: ls1028a: sl28: fix on-board EEPROMS
In-Reply-To: <20200311071613.GL29269@dragon>
References: <20200225175756.29508-1-michael@walle.cc>
 <20200225175756.29508-2-michael@walle.cc> <20200311071613.GL29269@dragon>
Message-ID: <ad7bd5b3286f00be2d43b696b40aeaae@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 0672923E74
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.310];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-03-11 08:16, schrieb Shawn Guo:
> On Tue, Feb 25, 2020 at 06:57:54PM +0100, Michael Walle wrote:
>> The module itself has another EEPROM at 50h on I2C4. The EEPROM on the
>> carriers is located at 57h on I2C3. Fix that in the device trees.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Doesn't apply to my branch.

Oh, sorry. there was a patch missing. I'll send a v2 shortly.

-michael
