Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1337D75D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 05:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGZDTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 23:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfGZDTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:19:22 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3198206E0;
        Fri, 26 Jul 2019 03:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564111161;
        bh=TA2/A7/aYVi+w9fs09QV2KgjxvFhSx9MDkIoEj1FfsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iqmmG2Ei81U1zJFShXG4vbqoELrd8E0IF2OEgDmM2vS9nZcHITvmNbnbW+1mcVOj1
         yBg1R7JmSxwa/w/Ou2BVMo9r5m1oJH5tkN4Lw4JEi2wiHfnZNZW2LKQz0gnzXqeJQB
         jsHKlRgRWoKBX/kiJaYIgpsvC5+LCDOhTe3fNhvc=
Date:   Thu, 25 Jul 2019 20:19:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rbtree: sync up the tools/ copy of the code with the
 main one
Message-Id: <20190725201920.fa67c2a95e975dcbb1f859af@linux-foundation.org>
In-Reply-To: <20190703034812.53002-1-walken@google.com>
References: <20190703034812.53002-1-walken@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Jul 2019 20:48:12 -0700 Michel Lespinasse <walken@google.com> wrote:

> I should probably have done this in the same commit that changed the
> main rbtree code to avoid generating code twice for the cached rbtree
> versions.
> 
> Not copying the reviewers of the previous change as tools/ is just another
> copy of it. Copying LKML anyway because the additional noise
> won't make as much of a difference there :)

That isn't really a changelog.  Could we please have a few words
describing the change?  Was it a simple `cp'?

