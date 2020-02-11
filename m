Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E186D1599B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 20:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgBKTZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 14:25:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33548 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgBKTZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:25:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so4676180plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 11:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fduhzb+WwBefc5G2IiZw7jkFkPhFvQRZKGxZZqFDo/E=;
        b=aBFZgI1bEVFMDfd8bvtXh9AZ1Mze2/1St6L/4BVij/mXj+0ZVWJe/BBz62kvdV/PUy
         KBlDmWnFixMHuEJ2x57jhZe2RZwo4KxOOAhGPDQppATODztQCUF1bGUHqwB2F+7dyFEs
         eKbWf5MArG16cSHqLbOgFxRg8G+4rPIDu1A8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fduhzb+WwBefc5G2IiZw7jkFkPhFvQRZKGxZZqFDo/E=;
        b=Hzn361BIh38YZagk8tlLURNpejW865wgYlXCrzdzB6BvJt1jWLo3vvc46tNPmwCFEY
         gYT8t6D/kXRt2Opz2tXWuLhY1I8r0AViuvkdEqUg/FQNqeIvRmH2+/+HfMBaGScrm6qK
         aw0qJe1bdyUIctuxjA6HZaKReEUnhtJp2854DK0MV6SIUSHyVRnWOcXOiSSt4lbJM9W5
         HqKIyOPOy0fASyJgv7Av2G4CLYtKdpZ3pqtLCzvR1UvRWD+a/NpZMKDXqZNnxhP2ZFlC
         vzpiZh7hMt0kXeif2xwHpvBt0TIppJ90AYo/FyjlUwN+HF+PNei3X1zwudscY+CwaYMM
         s/zQ==
X-Gm-Message-State: APjAAAVKtHG0ZqWxIELeSW4ImslDmh/O8F5ZHOcWrx484tmpMcp7T+u/
        XlQwkYJCGp4obD1I8NSKXxZbtLUDcpg=
X-Google-Smtp-Source: APXvYqzYyVOg7uqgSBmTXebLQ5IGOoof6bohkjL6i/HNSEw99SG6fXpTLlzi3kbK2a4VrLpxXNd1Pg==
X-Received: by 2002:a17:90a:b30b:: with SMTP id d11mr6814381pjr.22.1581449148710;
        Tue, 11 Feb 2020 11:25:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3sm4285511pjg.27.2020.02.11.11.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 11:25:47 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:25:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     shuah <shuah@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 7/7] selftests/exec: Add READ_IMPLIES_EXEC tests
Message-ID: <202002111124.0A334167@keescook>
References: <20200210193049.64362-1-keescook@chromium.org>
 <20200210193049.64362-8-keescook@chromium.org>
 <4f8a5036-dc2a-90ad-5fc8-69560a5dd78e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8a5036-dc2a-90ad-5fc8-69560a5dd78e@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:11:21AM -0700, shuah wrote:
> On 2/10/20 12:30 PM, Kees Cook wrote:
> > In order to check the matrix of possible states for handling
> > READ_IMPLIES_EXEC across native, compat, and the state of PT_GNU_STACK,
> > add tests for these execution conditions.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> No issues for this to go through tip.
> 
> A few problems to fix first. This fails to compile when 32-bit libraries
> aren't installed. It should fail the 32-bit part and run other checks.

Do you mean the Makefile should detect the missing compat build deps and
avoid building them? Testing compat is pretty important to this test, so
it seems like missing the build deps causing the build to fail is the
correct action here. This is likely true for the x86/ selftests too.

What would you like this to do?

-- 
Kees Cook
