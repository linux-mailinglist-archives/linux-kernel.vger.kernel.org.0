Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F291804CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCJRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:30:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:44156 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgCJRaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:30:05 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BBDBA823;
        Tue, 10 Mar 2020 17:30:04 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:30:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sameer Rahmani <lxsameer@gnu.org>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to kobject doc ReST conversion
Message-ID: <20200310113003.0d6d301d@lwn.net>
In-Reply-To: <20200304110821.7243-1-lukas.bulwahn@gmail.com>
References: <20200304110821.7243-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Mar 2020 12:08:21 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 5fed00dcaca8 ("Documentation: kobject.txt has been moved to
> core-api/kobject.rst") missed to adjust the entry in MAINTAINERS.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: Documentation/kobject.txt
> 
> Adjust DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS entry in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Sameer, please ack.
> Jonathan, pick pick this patch for doc-next.

Applied, thanks.

jon
