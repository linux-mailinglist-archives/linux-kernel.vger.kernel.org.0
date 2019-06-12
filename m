Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6341A29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 03:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406408AbfFLB71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 21:59:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33828 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405070AbfFLB71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AWbKt2KtWgJTN1uxsnE88jLMLGW5ow0PSYeJXbPq6D0=; b=FxB20MgmijgBY8UZBKxmqlg2Je
        swFzOpXdpuGK99HU2Z/g9alsu7k548SvovP+5CtEhp0yb4JwLDsLkwXQM1lC07pEqO32Qjv01JTfM
        /ZTIlIErGZtuFK/UGgciuxgUneo7WhDUp9nxnXxvTP9Pzf9UZZ/wOYoNn42gcmXg1iUfa62R+qRuF
        MVlo8/ubiGxLmCJ/Iin6RQUEUdghV3GFWf02LjpsMHWj+8CDs3PGw4q2w3Ztkh3EhylXS1PJXNBfG
        ykXCYrHI06XXcPFZUVqibJyJRBBGnsDKGfHIXf7zyifFh3wEcCUyVvNt+wf6Ydq4mypep1B6uVJyn
        Q0x6LdkQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hasXr-0002Sm-UX; Wed, 12 Jun 2019 01:59:24 +0000
To:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next 20190611: objtool warning
Message-ID: <a9ceb8f8-f2fd-e57d-3428-aaf50e011a43@infradead.org>
Date:   Tue, 11 Jun 2019 18:59:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

New warning AFAIK:

drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0x11f: sibling call from callable instruction with modified stack frame


> gcc --version
gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538]


-- 
~Randy
