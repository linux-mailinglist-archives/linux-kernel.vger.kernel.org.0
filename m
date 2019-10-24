Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769BBE38AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439926AbfJXQq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 12:46:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49000 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439916AbfJXQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:46:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 31E891477CBB0;
        Thu, 24 Oct 2019 09:46:26 -0700 (PDT)
Date:   Thu, 24 Oct 2019 09:46:23 -0700 (PDT)
Message-Id: <20191024.094623.2182520936177775102.davem@davemloft.net>
To:     steven.price@arm.com
Cc:     linux-mm@kvack.org, luto@kernel.org, ard.biesheuvel@linaro.org,
        arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, mingo@redhat.com, james.morse@arm.com,
        jglisse@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark.Rutland@arm.com, kan.liang@linux.intel.com,
        akpm@linux-foundation.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v13 09/22] sparc: mm: Add p?d_leaf() definitions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191024093716.49420-10-steven.price@arm.com>
References: <20191024093716.49420-1-steven.price@arm.com>
        <20191024093716.49420-10-steven.price@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 24 Oct 2019 09:46:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Price <steven.price@arm.com>
Date: Thu, 24 Oct 2019 10:37:03 +0100

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_leaf() functions/macros.
> 
> For sparc 64 bit, pmd_large() and pud_large() are already provided, so
> add macros to provide the p?d_leaf names required by the generic code.
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
