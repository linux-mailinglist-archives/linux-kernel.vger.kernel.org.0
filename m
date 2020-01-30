Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD514E2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 20:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgA3TKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 14:10:09 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:16031 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgA3TKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:10:09 -0500
Date:   Thu, 30 Jan 2020 19:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580411406;
        bh=B793CPK7LFZlogFfXtw3UaxaxhpPATfXTFrDbkKkc18=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=xTVum6uCmTJ+JCOIv6JPfPZachOF+tuUjb97ymAqmThugbzSW9Y68ynTokTLqUpLb
         oneS9WeREjHNj7S3xdV12+3udnxVpMXUN6pkNKNmau7w9kHncJrjeyW4jrASxRYHw3
         CZvPGDYpXIUmPRd3vq0vFEUD5zSGFUwNpIcygOoA=
To:     "linux-kernel\\@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo\\@redhat.com" <mingo@redhat.com>,
        "bp\\@alien8.de" <bp@alien8.de>, "hpa\\@zytor.com" <hpa@zytor.com>,
        "x86\\@kernel.org" <x86@kernel.org>,
        "rafael.j.wysocki\\@intel.com" <rafael.j.wysocki@intel.com>,
        "drake\\@endlessm.com" <drake@endlessm.com>,
        "viresh.kumar\\@linaro.org" <viresh.kumar@linaro.org>,
        "juri.lelli\\@redhat.com" <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich\\@akamai.com" <mzhivich@akamai.com>,
        "malat\\@debian.org" <malat@debian.org>,
        "piecuch@protonmail.com" <piecuch@protonmail.com>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_early_khz command line parameter overriding early TSC calibration
Message-ID: <WIxfn1FPETITrmzdhnFHwujR0uEbHZ44PWZgmtRAzmj4rJ4wfzQUbcSWMtneOk0p7HkbJubs0z1BSLaBY3IXJarup8Ukw7Kv0WWYNgPk5bo=@protonmail.com>
In-Reply-To: <O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com>
References: <O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I please have some feedback on this patch?


Kind regards,
Krzysztof Piecuch

