Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995B9129B71
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 23:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLWWZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 17:25:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfLWWZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:25:53 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC643206CB;
        Mon, 23 Dec 2019 22:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577139953;
        bh=5aMaM5UVt54PsEDXZJzFRawKZxOG0oyvOuZbI/OOOGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wolt0qChOLq8tmz5oBNi17H9c7dvEGVOx9+4veDYvCwtoC0bz9UAWX1nKyhXGZjeH
         k+3OVfD7KJ5VjAgKFpLnjj65qa2B4VmsK5uvIbCht/e4F50eP5R53/w0gy7u8w0v9+
         rgBmAOO1xjaoZQgYilKT3pJ2XsCDxBPxhZRqCWkM=
Date:   Mon, 23 Dec 2019 14:25:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Willhalm, Thomas" <thomas.willhalm@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bruggeman, Otto G" <otto.g.bruggeman@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/2] Fix two above-47bit hint address vs. THP bugs
Message-Id: <20191223142552.d9bd85e588196d17fb90ee2e@linux-foundation.org>
In-Reply-To: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
References: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 17:25:46 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> The two get_unmapped_area() implementations have to be fixed to provide
> THP-friendly mappings if above-47bit hint address is specified.
> 

Do we need a cc:stable for these?
