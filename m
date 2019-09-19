Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE70B775C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389306AbfISKZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 06:25:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389206AbfISKZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:25:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46YtKX0lTNz9sPh; Thu, 19 Sep 2019 20:25:51 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a3db31ff6ce31f5a544a66b61613a098029031cc
In-Reply-To: <8f6f14d192a994008ac370ce14036bbe67224c7d.1567707399.git.naveen.n.rao@linux.vnet.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] ftrace: Look up the address of return_to_handler() using helpers
Message-Id: <46YtKX0lTNz9sPh@ozlabs.org>
Date:   Thu, 19 Sep 2019 20:25:51 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 18:20:28 UTC, "Naveen N. Rao" wrote:
> This ensures that we use the right address on architectures that use
> function descriptors.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a3db31ff6ce31f5a544a66b61613a098029031cc

cheers
