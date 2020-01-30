Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755C714E0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 19:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgA3S3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 13:29:04 -0500
Received: from gentwo.org ([3.19.106.255]:40996 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729845AbgA3S3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:29:03 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 5A4FE3FFFB; Thu, 30 Jan 2020 18:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 595523E94E;
        Thu, 30 Jan 2020 18:29:03 +0000 (UTC)
Date:   Thu, 30 Jan 2020 18:29:03 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, dennis@kernel.org, tj@kernel.org,
        elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/util: annotate an intentional data race
In-Reply-To: <20200130145649.1240-1-cai@lca.pw>
Message-ID: <alpine.DEB.2.21.2001301828360.9861@www.lameter.com>
References: <20200130145649.1240-1-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020, Qian Cai wrote
> "vm_committed_as.count" could be accessed concurrently as reported by
> KCSAN,

Acked-by: Christoph Lameter <cl@linux.com>
