Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5D3BE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 23:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390447AbfFJVVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 17:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390072AbfFJVUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:20:35 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253C220859;
        Mon, 10 Jun 2019 21:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560201634;
        bh=gk2LT6fcQsSzPtvSDO++ABbQbp8Uy6r4UjS6ey/0Juc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K33EzM6D4Va30ZI5NAiOD9fA+ukRykQXFJG5QhB6faCgv/G+xtgEoePHQSqT5UjMf
         Bivmju9CUBeJZRonOrZqoGsgPv0BZspRU37kfy3jf/Fs2eucmqTIhI2BCqIwrogQjH
         ZNVIH2JyUj2bBFOcXqonoxSslpKMrOvFcjoAwiYE=
Date:   Mon, 10 Jun 2019 14:20:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        "Chen, Jerry T" <jerry.t.chen@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: soft-offline: return -EBUSY if
 set_hwpoison_free_buddy_page() fails
Message-Id: <20190610142033.6096a8ec73d4bf40b2612fb5@linux-foundation.org>
In-Reply-To: <1560154686-18497-2-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1560154686-18497-1-git-send-email-n-horiguchi@ah.jp.nec.com>
        <1560154686-18497-2-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 17:18:05 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:

> The pass/fail of soft offline should be judged by checking whether the
> raw error page was finally contained or not (i.e. the result of
> set_hwpoison_free_buddy_page()), but current code do not work like that.
> So this patch is suggesting to fix it.

Please describe the user-visible runtime effects of this change?
