Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588142C7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfE1Nij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 09:38:39 -0400
Received: from foss.arm.com ([217.140.101.70]:57836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfE1Nii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:38:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51FF380D;
        Tue, 28 May 2019 06:38:38 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D3263F5AF;
        Tue, 28 May 2019 06:38:36 -0700 (PDT)
Date:   Tue, 28 May 2019 14:38:34 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [kvmtool PATCH v10 5/5] KVM: arm/arm64: Add a vcpu feature for
 pointer authentication
Message-ID: <20190528133833.GC28398@e103592.cambridge.arm.com>
References: <1555994558-26349-1-git-send-email-amit.kachhap@arm.com>
 <1555994558-26349-6-git-send-email-amit.kachhap@arm.com>
 <20190423154625.GP3567@e103592.cambridge.arm.com>
 <3b7bafc9-5d6a-7845-ef1f-577ea59000e2@arm.com>
 <20190424134120.GW3567@e103592.cambridge.arm.com>
 <20190528101128.GB28398@e103592.cambridge.arm.com>
 <53ecc253-e9e0-a6ca-2540-fa85bd26bfc1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ecc253-e9e0-a6ca-2540-fa85bd26bfc1@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 06:18:16PM +0530, Amit Daniel Kachhap wrote:
> Hi Dave,

[...]

> >Were you planning to repost this?
> >
> >Alternatively, I can fix up the diagnostic messages discussed here and
> >post it together with the SVE support.  I'll do that locally for now,
> >but let me know what you plan to do.  I'd like to get the SVE support
> >posted soon so that people can test it.
> 
> I will clean up the print messages as you suggested and repost it shortly.

OK, thanks.

In the meantime I'll rework the SVE config option stuff on what we
discussed.

Cheers
---Dave
