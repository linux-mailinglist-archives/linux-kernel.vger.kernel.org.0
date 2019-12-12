Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC211D5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 19:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfLLSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 13:38:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52402 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfLLSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:38:50 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifTMO-0001jZ-7r; Thu, 12 Dec 2019 18:38:48 +0000
Date:   Thu, 12 Dec 2019 18:38:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove ksys_dup()
Message-ID: <20191212183848.GJ4203@ZenIV.linux.org.uk>
References: <20191212140752.347520-1-linux@dominikbrodowski.net>
 <20191212140752.347520-3-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212140752.347520-3-linux@dominikbrodowski.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 03:07:52PM +0100, Dominik Brodowski wrote:
> ksys_dup() is used only at one place in the kernel, namely to duplicate
> fd 0 of /dev/console to stdout and stderr. The same functionality can be
> achieved by using functions already available within the kernel namespace.

Let's not expose the kernel guts to init/*.c more than absolutely unavoidable.
