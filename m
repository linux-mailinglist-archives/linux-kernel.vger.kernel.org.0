Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523F291CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 08:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfHSGRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 02:17:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHSGRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:17:52 -0400
Received: from zn.tnic (p200300EC2F04B700DD16340F367BA899.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:dd16:340f:367b:a899])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CA9D1EC072D;
        Mon, 19 Aug 2019 08:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566195471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tij8cUPtjlXBKM4Vt2vKmoASpHF0u05wcnukynHg88Y=;
        b=cv2oEIevx6RQAjKhn9EqEh82mDGBtttH2QjyhXEwIatTUCGo3hIvmlf45xQt8YqYrW5qpI
        l8kk59VaETbHymgum6O2Y8VBEIfC3k8WhgBBqSS73s5abTCQ8O0AzbjNsXmNTlkt/RfyLr
        w2gMqpDhmjOYD3yRf07U/7csjjkRkGs=
Date:   Mon, 19 Aug 2019 08:18:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhao, Yakui" <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
Message-ID: <20190819061840.GB4841@zn.tnic>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <20190816063925.GB18980@zn.tnic>
 <78897bb2-e6eb-cac2-7166-eccb7cd5c959@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78897bb2-e6eb-cac2-7166-eccb7cd5c959@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 09:44:25AM +0800, Zhao, Yakui wrote:
> Not sure whether it can be sent in two patch sets?
> The first is to add the required APIs for ACRN driver.
> The second is to add the ACRN driver

One patchset adding the APIs and its user(s).

And make sure to refresh on

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

before sending.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
