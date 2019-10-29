Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BEFE8C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 17:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390349AbfJ2QJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 12:09:32 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:59234 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390200AbfJ2QJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:09:32 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iPU3f-0006Vk-M6; Tue, 29 Oct 2019 17:09:23 +0100
Date:   Tue, 29 Oct 2019 17:09:23 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Praveen Chaudhary <praveen5582@gmail.com>
Cc:     davem@davemloft.net, fw@strlen.de, kadlec@netfilter.org,
        pablo@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhenggen Xu <zxu@linkedin.com>,
        Andy Stracner <astracner@linkedin.com>
Subject: Re: [PATCH] [netfilter]: Fix skb->csum calculation when netfilter
 manipulation for NF_NAT_MANIP_SRC\DST is done on IPV6 packet.
Message-ID: <20191029160923.GB876@breakpoint.cc>
References: <1572301675-5403-1-git-send-email-pchaudhary@linkedin.com>
 <1572301675-5403-2-git-send-email-pchaudhary@linkedin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572301675-5403-2-git-send-email-pchaudhary@linkedin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Praveen Chaudhary <praveen5582@gmail.com> wrote:
> No need to update skb->csum in function inet_proto_csum_replace16(),
> even if skb->ip_summed == CHECKSUM_COMPLETE, because change in L4
> header checksum field and change in IPV6 header cancels each other
> for skb->csum calculation.

Can you resend this and submit this patch to
netfilter-devel@vger.kernel.org?

You may add:
Reviewed-by: Florian Westphal <fw@strlen.de>
