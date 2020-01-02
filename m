Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9885912E7A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 15:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgABO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 09:59:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:55376 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgABO7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:59:24 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E2DF9A0;
        Thu,  2 Jan 2020 14:59:23 +0000 (UTC)
Date:   Thu, 2 Jan 2020 07:59:22 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Anup Patel <anup@brainfault.org>
Cc:     Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] riscv: gcov: enable gcov for RISC-V
Message-ID: <20200102075922.301cf1ec@lwn.net>
In-Reply-To: <CAAhSdy0NW9OTGOGoyZ7QmAOVbR_iF2ZM7b9eKDW0U1L+as-oaA@mail.gmail.com>
References: <20200102030954.41225-1-zong.li@sifive.com>
        <CAAhSdy0NW9OTGOGoyZ7QmAOVbR_iF2ZM7b9eKDW0U1L+as-oaA@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 09:07:12 +0530
Anup Patel <anup@brainfault.org> wrote:

> May be (not 100% sure) split this into two patches so that
> Documentation patch can be taken by Jonathan.

That's fine if you want, but this patch can also easily go together
through the risc-v tree.

Acked-by: Jonathan Corbet <corbet@lwn.net>

jon
