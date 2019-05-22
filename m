Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893BE270DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 22:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfEVUfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 16:35:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:49210 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfEVUfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:35:08 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 58121AAB;
        Wed, 22 May 2019 20:35:07 +0000 (UTC)
Date:   Wed, 22 May 2019 14:35:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/sphinx-pre-install: make it handle Sphinx
 versions
Message-ID: <20190522143506.34049678@lwn.net>
In-Reply-To: <a741574b7081c162d200bdead35302ccac6fd116.1558545958.git.mchehab+samsung@kernel.org>
References: <a741574b7081c162d200bdead35302ccac6fd116.1558545958.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 13:28:34 -0400
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> As we want to switch to a newer Sphinx version in the future,
> add some version detected logic, checking if the current
> version meets the requirement and suggesting upgrade it the
> version is supported but too old.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

I've applied this in the branch with my other fixes (coming soon to a
mailing list near you), thanks.  I do think we eventually want to emit a
warning during a normal docs build as well, and to raise the recommended
version, but one step at a time...

jon
