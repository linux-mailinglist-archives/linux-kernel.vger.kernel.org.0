Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83D514C58E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 06:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgA2FR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 00:17:59 -0500
Received: from ozlabs.org ([203.11.71.1]:36931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgA2FRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:41 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sF01mqkz9sS3; Wed, 29 Jan 2020 16:17:40 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f1dbc1c5c70d0d4c60b5d467ba941fba167c12f6
In-Reply-To: <5577aef8-1d5a-ca95-ff0a-9c7b5977e5bf@linux.ibm.com>
To:     Michael Bringmann <mwb@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Gustavo Walbon <gwalbon@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2] Fix display of Maximum Memory
Message-Id: <486sF01mqkz9sS3@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:40 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-15 at 14:53:59 UTC, Michael Bringmann wrote:
> Correct overflow problem in calculation+display of Maximum Memory
> value to syscfg where 32bits is insufficient.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f1dbc1c5c70d0d4c60b5d467ba941fba167c12f6

cheers
