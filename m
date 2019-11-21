Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712B5105262
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 13:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUMrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 07:47:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:24402 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUMrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:47:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 04:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,224,1571727600"; 
   d="scan'208";a="205138454"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2019 04:47:31 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E6A7B300B64; Thu, 21 Nov 2019 04:47:29 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Optimize perf stat for large number of events/cpus
References: <20191121001522.180827-1-andi@firstfloor.org>
Date:   Thu, 21 Nov 2019 04:47:29 -0800
In-Reply-To: <20191121001522.180827-1-andi@firstfloor.org> (Andi Kleen's
        message of "Wed, 20 Nov 2019 16:15:10 -0800")
Message-ID: <878so9flb2.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <andi@firstfloor.org> writes:

> [v8: Address review feedback. Only changes one patch.]

Sorry forgot to add the -v8 to the subject.

The patches in this thread are version 8.

I'll not repost with the new Subject unless someone asks me to.

-Andi
