Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A567115FFBA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 19:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgBOSjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 13:39:40 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:53309 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgBOSjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 13:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dSonFg/wT1PhOFMeG2cNMDkAO52fBhiLonIuIbHmC2g=; b=eqRKVhCOH9XrtYitzrQUJIk9hT
        VqrT2h1/nQJRkFvZF9MsnRo1PtUm9bJQ+MpdIIPFd4IWwhKQaR03wAtoKErFJ3uVQsLfqqDAeO+i3
        aAn75yDXdY4fAnbfIHhjbNtdtpkWZdoO5askQ2G53AHaMuSDKdwqhIeSjS0l7rIxnMmAYpxc9jsuM
        srvTiUuyphbfPRcXgslqx9co5PKgRLPmKLug8KZcknJRq6OfGnhUulVCVshKBh8L4AXCAF+R2aXSa
        LQiQYu4fORY7zhZkEu5k727ztNo7vyOEiQHsOvoIxbfpklQauDOPNBGrxfaBxqkAroqXbmMXQYWgB
        jnsS48Gg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53543 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1j32Lq-00059M-2P; Sat, 15 Feb 2020 19:39:38 +0100
Subject: Re: [PATCH v2 1/2] drm/client: Dual licence the file in GPL-2 and MIT
To:     Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@intel.com,
        efremov@linux.com, tzimmermann@suse.de, sam@ravnborg.org,
        chris@chris-wilson.co.uk, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200215180911.18299-1-manu@FreeBSD.org>
 <20200215180911.18299-2-manu@FreeBSD.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <fa7fef1d-6619-5d2e-6274-6883acfb55d6@tronnes.org>
Date:   Sat, 15 Feb 2020 19:39:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215180911.18299-2-manu@FreeBSD.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 15.02.2020 19.09, skrev Emmanuel Vadot:
> From: Emmanuel Vadot <manu@FreeBSD.Org>
> 
> Contributors for this file are :
> Chris Wilson <chris@chris-wilson.co.uk>
> Denis Efremov <efremov@linux.com>
> Jani Nikula <jani.nikula@intel.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Trønnes <noralf@tronnes.org>
> Sam Ravnborg <sam@ravnborg.org>
> Thomas Zimmermann <tzimmermann@suse.de>
> 
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>

