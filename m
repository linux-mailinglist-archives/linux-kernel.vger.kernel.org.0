Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B427A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfEWKYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWKYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:24:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4D821019;
        Thu, 23 May 2019 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558607060;
        bh=wwEsmD+B8RSaHZAKiFtbTCvX2vdCBpasMFVbWCQ5tUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1I4s6xoKw0XEzKVK2nCyE9doCMYwomT9ZM2H8Hv08ZogY6duNmL+QLwuubYtZg2E
         5WM9aSatQshuvFuOOG/EeypRrPtBlSG68V4lBvG78mzUj2LBHWrj3M5OjD/iIzTA2i
         2noeAO11qIpLDFVjsj1eY01b7bg1fy7/kVPfEZXA=
Date:   Thu, 23 May 2019 12:24:17 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     TonyWWang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v1 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Message-ID: <20190523102417.GC11016@kroah.com>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:10:52AM +0000, TonyWWang-oc wrote:
> Add x86 architecture support for new Zhaoxin processors.
> Carve out initialization code needed by Zhaoxin processors into
> a separate compilation unit.
> 
> To identify Zhaoxin CPU, add a new vendor type X86_VENDOR_ZHAOXIN
> for system recognition.
> 
> Signed-off-by: TonyWWang <TonyWWang-oc@zhaoxin.com>

Some basic patch tips.  Your From: line needs to match the signed-off-by
line, which is not true here.  Also, please use your name with ' '
characters.

> +static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
> +{
> +   u32  lo, hi;
> +
> +   /* Test for Extended Feature Flags presence */
> +   if (cpuid_eax(0xC0000000) >= 0xC0000001) {
> +      u32 tmp = cpuid_edx(0xC0000001);

This patch is totally corrupted, with leading spaces dropped and tabs
turned into spaces.  Please read the email client documentation in the
kernel directory for how to fix your email client, or just use 'git
send-email' to send the patches out directly.

thanks,

greg k-h
