Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7510DF0D4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 04:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfKFDts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 22:49:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfKFDts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:49:48 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E8621882;
        Wed,  6 Nov 2019 03:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573012188;
        bh=R0k687jKIawmp0izD2jnWCCfNUjEePWNDcR2yufXD5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bxlc+ypg3CPUbLLNQyYlWZcJc4DxhRgYmY19Qkc2JcL1hM6PajmWiw/QAK0g7TgbW
         VVUWLN1CvdM7NAR5Z2KyLe7KAehur9mSU/LbegQPQc4rDhVGuzfOqcU+rB2XsxB8gy
         fa7J5QjWeqUyDoyQyQLkaHYIxfBYCM3tJG/w9Rlk=
Date:   Tue, 5 Nov 2019 19:49:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v6 3/8] mm: Add a walk_page_mapping() function to the
 pagewalk code
Message-Id: <20191105194947.0f78f903803c58203125f801@linux-foundation.org>
In-Reply-To: <20191014132204.7721-4-thomas_os@shipmail.org>
References: <20191014132204.7721-1-thomas_os@shipmail.org>
        <20191014132204.7721-4-thomas_os@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 15:21:59 +0200 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> For users that want to travers all page table entries pointing into a
> region of a struct address_space mapping, introduce a walk_page_mapping()
> function.
>=20
> The walk_page_mapping() function will be initially be used for dirty-
> tracking in virtual graphics drivers.

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
