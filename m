Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D518861F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 14:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQNof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 09:44:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgCQNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ufve2virW4ALgDJ+q7Wgs5h7YmbZzdya8zKc7ZzwdaA=; b=bA9tcrXOdGO7zm4QPXm0NQIhPJ
        iT8es212NFAEYGvMn25QKCRoLijX6QJ3tPkM9rH0xvghg/j5gDwENtEByC10w52MtXlmgZGaqp1uF
        5qjBNHmToG33CgyhF/eZTLEusW8nMypdAC6Rr2VH2GAUy4JNmTwhAgd/uY/iwKbQqRih1WCtsAXtB
        1YouUItWWeL8E3EbB1nquIH4b3F+eqwbfWdrLiS+slrAaa38pvrJIrHDJA7WFZFsFRHzHGZIOyDAG
        7KSapjyEpaepBJaDcowfQEUU+CrlptdOY1hAj67TG0piwAIBNskmThDEdN/rTYX62uRT0klCRy3by
        cmEgE5PA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jECWI-0002se-IW; Tue, 17 Mar 2020 13:44:34 +0000
Date:   Tue, 17 Mar 2020 06:44:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 31/42] docs: scsi: convert scsi_mid_low_api.txt to ReST
Message-ID: <20200317134434.GA10514@infradead.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
 <881e7741dfed5d6f5f73e1dfc2826b200b8604aa.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <881e7741dfed5d6f5f73e1dfc2826b200b8604aa.1583136624.git.mchehab+huawei@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Much of this file just duplicates the kerneldoc comments in the source
files.  IF you convert it to rest it should reference those instead of
duplicating them.

Then again I'm not sure this file is useful at all any more..
