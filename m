Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACDA1371C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgAJPvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 10:51:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42984 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgAJPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:51:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so1319264pfz.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9yn885qD54fB5dDn+OfSRgsgfTlFfhcqDGic7B3Aag=;
        b=N7d77Zlz7JlJ1aEZ2kcsr+1isJ0PTKTKt2JzoypNpcuRniw3hbIu21z/XvrfDkKiKB
         Mqh8c03o7oFen4sFQi0LrOjojdOaYFz03ARWLZ/atMQS1jp46hnwrTr8bGPW+jrxHORj
         Msw3Cide5jPRSQ17ISIsmfjQ50Q3q9nPU1NNC0THx6s4K2GlHOdAgWECiNjlkmkt1Oxb
         c5QOwVJExL1sCA7KuJ7cydRmenfClTtZw7gOO4D/1NtB0XJgy+H+kF2WX8oKqCC2QwZm
         zpsdMqFV7/K4dZeX62HEK48WKNrOd7FD5KiSrd8yaECATzMQteALSjlpvu2g5VnFR5tP
         RWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9yn885qD54fB5dDn+OfSRgsgfTlFfhcqDGic7B3Aag=;
        b=evey0WO5mOvd0/6p4XpXw+wJgaVScGMrEpSj4EWY0cUeI4IVfK7EgW2WWfhJaEPUOl
         aRPP1df293PQjmFRgUfAOC5hVfhSrsKRcFsOGIsiHCJL5xMeixzmhLNMmiwUfrdhBVcm
         cUHDY78fC7bodEWgTEXyK2GhlIB9pCmxpsJ37u6SCu9KUAeqrRpUjrpeKgrpNjjStVlo
         fC2PTnKzRnuGWizVqcqdtkYnaJeMxeQUfIPiK1m5xE5CJRRJAlm3617wtPZ03bEEfb1Y
         O0rz+3QQcBroQQjllRfuTMlDPVCtdgVU3NHnUxDAV1mUbsux0nLfxaMq2KkgPeA6/IIu
         d6pw==
X-Gm-Message-State: APjAAAV+pqGZP047VhTWJYSlEg2yAaisg0jKHBOj9EU8DBczntvltuUP
        go93y9zcEoGHiTR3iVCTL/kUwA==
X-Google-Smtp-Source: APXvYqyr7d+yr0ozi0RepBQKh4gi5iEX1Vm3TUIkcSoGrtjD9PKcQuhSpSAR/9rzQT0qsXD6E7V5ug==
X-Received: by 2002:a63:4824:: with SMTP id v36mr5157093pga.343.1578671497048;
        Fri, 10 Jan 2020 07:51:37 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b19sm3235904pjq.8.2020.01.10.07.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:51:36 -0800 (PST)
Date:   Fri, 10 Jan 2020 07:50:56 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Niu Xilei <niu_xilei@163.com>
Cc:     davem@davemloft.net, tglx@linutronix.de, fw@strlen.de,
        peterz@infradead.org, pabeni@redhat.com, anshuman.khandual@arm.com,
        linyunsheng@huawei.com, bigeasy@linutronix.de,
        jonathan.lemon@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     pktgen: create packet use  IPv6 source address
 between src6_min and src6_max.
Message-ID: <20200110075056.06df4c0c@hermes.lan>
In-Reply-To: <20200110102842.13585-1-niu_xilei@163.com>
References: <20200110102842.13585-1-niu_xilei@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:28:42 +0800
Niu Xilei <niu_xilei@163.com> wrote:

> +/* Kernel not implement __int128's divide and modulo operator. Implement these
> + * operation use shift-subtract division algorithm  adpater from
> + * https://chromium.googlesource.com/chromium/src/third_party/+/master/abseil-cpp/absl/numeric/int128.cc */

Some rewording of this comment is necessary to fix the English grammar.
And Linux style is not to put comment closing on same line.

Something like:

/* The Linux kernel does not implement 128 bit divide and modulus operations.
 * Implement these operations using shift-subtract division algorithm
 * from Chrome.
 * https://chromium.googlesource.com/chromium/src/third_party/+/master/abseil-cpp/absl/numeric/int128.cc
 */

Also, the int128 code you referenced is Apache licensed (not GPL-v2 like kernel).

For div128_u128 the function should be static to avoid name conflicts.

The declarations need to be in reverse christmas tree order as well.

It does seem a bit like overkill since doing source address over a 64 bit
range should be more than enough for any test in this decade.
