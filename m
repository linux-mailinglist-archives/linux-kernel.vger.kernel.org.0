Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C52112E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 16:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfLDPYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 10:24:10 -0500
Received: from gentwo.org ([3.19.106.255]:46958 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDPYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:24:10 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 8D1393EED9; Wed,  4 Dec 2019 15:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 8C3343EBB9;
        Wed,  4 Dec 2019 15:24:09 +0000 (UTC)
Date:   Wed, 4 Dec 2019 15:24:09 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2] fix __percpu annotation in asm-generic
In-Reply-To: <20191204010623.65384-1-luc.vanoostenryck@gmail.com>
Message-ID: <alpine.DEB.2.21.1912041523010.18825@www.lameter.com>
References: <20191204010623.65384-1-luc.vanoostenryck@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019, Luc Van Oostenryck wrote:

> using the fact that typeof() ignores the address space and the
> 'noderef' attribute of its agument.

Acked-by: Christoph Lameter <cl@linux.com>
