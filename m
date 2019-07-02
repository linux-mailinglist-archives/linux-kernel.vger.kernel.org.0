Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2E95D3F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGBQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 12:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfGBQLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:11:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9DABB023;
        Tue,  2 Jul 2019 16:11:36 +0000 (UTC)
Date:   Tue, 2 Jul 2019 09:11:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] augmented rbtree: add comments for
 RB_DECLARE_CALLBACKS macro
Message-ID: <20190702161130.7uu4yk3rzqiyfbab@linux-r8p5>
References: <20190702075819.34787-1-walken@google.com>
 <20190702075819.34787-2-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190702075819.34787-2-walken@google.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jul 2019, Michel Lespinasse wrote:

>Add a short comment summarizing the arguments to RB_DECLARE_CALLBACKS.
>The arguments are also now capitalized. This copies the style of the
>INTERVAL_TREE_DEFINE macro.
>
>No functional changes in this commit, only comments and capitalization.
>
>Signed-off-by: Michel Lespinasse <walken@google.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
