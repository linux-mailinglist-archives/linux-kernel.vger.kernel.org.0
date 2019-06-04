Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF635027
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfFDTIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 15:08:39 -0400
Received: from ms.lwn.net ([45.79.88.28]:56986 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfFDTIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:08:39 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EFEA07DE;
        Tue,  4 Jun 2019 19:08:38 +0000 (UTC)
Date:   Tue, 4 Jun 2019 13:08:37 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
Message-ID: <20190604130837.24ea1d7b@lwn.net>
In-Reply-To: <20190601154248.GA17800@mit.edu>
References: <20190530135317.3c8d0d7b@lwn.net>
        <20190601154248.GA17800@mit.edu>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jun 2019 11:42:48 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> Finally, I'm bit concerned about anything which states absolutes,
> because there are people who tend to be real stickler for the rules,
> and if they see something stated in absolute terms, they fail to
> understand that there are exceptions that are well understood, and in
> use for years before the existence of the document which is trying to
> codify best practices.

Hence the "there are exceptions" text at the bottom of the document :)

Anyway, I'll rework it to try to take your comments into account.  Maybe
we should consistently say "rebasing" for changing the parent commit of a
patch set, and "history modification" for the other tricks...?

Thanks for taking a look,

jon
