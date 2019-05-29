Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AAA2E85E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 00:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfE2WgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 18:36:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:43906 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbfE2WgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:36:01 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A39176D9;
        Wed, 29 May 2019 22:36:00 +0000 (UTC)
Date:   Wed, 29 May 2019 16:35:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/sphinx-pre-install: make activate hint smarter
Message-ID: <20190529163559.258b2a51@lwn.net>
In-Reply-To: <582e6b7351f619d92035db8cfe24ecec5d95a489.1558610037.git.mchehab+samsung@kernel.org>
References: <582e6b7351f619d92035db8cfe24ecec5d95a489.1558610037.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 08:14:02 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> It is possible that multiple Sphinx virtualenvs are installed
> on a given kernel tree. Change the logic to get the latest
> version of those, as this is probably what the user wants.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied, thanks.

jon
