Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47656138B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2019 05:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfGGDCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 23:02:52 -0400
Received: from namei.org ([65.99.196.166]:33944 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfGGDCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 23:02:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6732cmU004446;
        Sun, 7 Jul 2019 03:02:38 GMT
Date:   Sat, 6 Jul 2019 20:02:38 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
cc:     serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/commoncap: Use xattr security prefix len
In-Reply-To: <20190706150738.4619-1-carmeli.tamir@gmail.com>
Message-ID: <alpine.LRH.2.21.1907062002050.4231@namei.org>
References: <20190706150738.4619-1-carmeli.tamir@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2019, Carmeli Tamir wrote:

> Using the existing defined XATTR_SECURITY_PREFIX_LEN instead of
> sizeof(XATTR_SECURITY_PREFIX) - 1. Pretty simple cleanup.
> 
> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lsm

Thanks! 

-- 
James Morris
<jmorris@namei.org>

