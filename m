Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E829DE873E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 12:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbfJ2LgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 07:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfJ2LgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:36:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 777EA20862;
        Tue, 29 Oct 2019 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572348971;
        bh=tlknb9NnrARnO/8Jo6xu68QaVQIAbSopr0LHFOUwm+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geGLqSfEdrnzxSm9FQfIRzAiLbtD2iIt8lyKJ6YUWqb3eNbFWglTqSONgv6jbCViU
         x0FY/02oXRKa8MrrU7G9szdibvAeRlEz73QLwwFPnfKdf6BbU8RjD9LQ7OSKnC/Klv
         qat2wwlVHkM5hSsLE0PUbjqz98Pz8DrGwv5Q8IRU=
Date:   Tue, 29 Oct 2019 11:36:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Dave.Martin@arm.com
Subject: Re: [PATCH] arm64: cpufeature: Export Armv8.6 Matrix feature to
 userspace
Message-ID: <20191029113606.GB12103@willie-the-truck>
References: <20191025171056.30641-1-julien.grall@arm.com>
 <20191029111517.GE11590@willie-the-truck>
 <f58cb01f-4543-6041-df2d-7ca7ba887bc9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58cb01f-4543-6041-df2d-7ca7ba887bc9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 11:26:41AM +0000, Julien Grall wrote:
> On 29/10/2019 11:15, Will Deacon wrote:
> > On Fri, Oct 25, 2019 at 06:10:56PM +0100, Julien Grall wrote:
> > > This patch provides support for reporting the presence of Armv8.6
> > > Matrix and its optional features to userspace.
> > 
> > Are you sure this is 8.6 and not earlier?
> 
> This was introduced by Armv8.6 see [1] but allowed to be used by Armv8.2 and
> onwards.

That doesn't mean an awful lot though, especially then the features are
referred to in the docs as things like "ARMv8.2-F64MM".

> > > @@ -227,6 +229,12 @@ infrastructure:
> > >        +------------------------------+---------+---------+
> > >        | Name                         |  bits   | visible |
> > >        +------------------------------+---------+---------+
> > > +     | F64MM                        | [56-59] |    y    |
> > > +     +------------------------------+---------+---------+
> > > +     | F32MM                        | [52-55] |    y    |
> > > +     +------------------------------+---------+---------+
> > > +     | I8MM                         | [44-47] |    y    |
> > > +     +------------------------------+---------+---------+
> > 
> > Urgh, we're inconsistent in our bitfields. Some are [lo-hi] whilst others
> > are [hi-lo]. Please can you fix that in a preparatory patch? I prefer
> > [hi-lo] and it matches the arch docs.
> 
> Sure.

Thanks.

Will
