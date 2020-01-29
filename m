Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C314C58D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgA2FRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:49 -0500
Received: from ozlabs.org ([203.11.71.1]:42999 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgA2FRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:47 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sF52DC0z9sSf; Wed, 29 Jan 2020 16:17:44 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: def0bfdbd6039e96a9eb2baaa4470b079daab0d4
In-Reply-To: <e041f5eedb23f09ab553be8a91c3de2087147320.1579800517.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] powerpc: use probe_user_read() and probe_user_write()
Message-Id: <486sF52DC0z9sSf@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:44 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-23 at 17:30:47 UTC, Christophe Leroy wrote:
> Instead of opencoding, use probe_user_read() to failessly read
> a user location and probe_user_write() for writing to user.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/def0bfdbd6039e96a9eb2baaa4470b079daab0d4

cheers
