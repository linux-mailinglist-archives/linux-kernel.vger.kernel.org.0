Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6A81130663
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 08:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAEHCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 02:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEHCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:02:44 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18BF20866;
        Sun,  5 Jan 2020 07:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578207763;
        bh=N3XRiR7CmsQsVRLAZucAVOasILmNQQtZLni2nmDCmMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeY1BTDvcMglSfXPB93lsmipOPUh4PNjZC6fWuH5QzMqHnAPA3+2hlmcdx+b1gRzJ
         lVvv+2qHHqoS5jJwn8LfdfPQ5omY1KB3swSZcxqQ0Nd5/OhBvhqlldib8qkKniVQEx
         DU4N5PvpX68p/g65Qjsoli11Bf62jl1BtfpwHj9g=
Date:   Sun, 5 Jan 2020 09:02:37 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: add support for folded p4d page tables
Message-ID: <20200105070236.GA7261@rapoport-lnx>
References: <20191209150908.6207-1-rppt@kernel.org>
 <20200102081059.GA12063@rapoport-lnx>
 <20200102174231.Horde.vA_c3sSHB1vhx2H9Ce-i9Q1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102174231.Horde.vA_c3sSHB1vhx2H9Ce-i9Q1@messagerie.si.c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 05:42:31PM +0100, Christophe Leroy wrote:
> Mike Rapoport <rppt@kernel.org> a écrit :
> 
> >Any updates on this?
> 
> Checkpatch reported several points, see
> https://patchwork.ozlabs.org/patch/1206344/

Well, for the most part checkpatch is unhappy because I've tried to keep
the changes consistent with the old code. And, there are some lines over 90
characters that do no seem worth breaking.

> Christophe
> 
