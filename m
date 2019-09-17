Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FADB589B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfIQXhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 19:37:40 -0400
Received: from pc-246-229-214-201.cm.vtr.net ([201.214.229.246]:46352 "EHLO
        mail.test.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726645AbfIQXhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:37:40 -0400
Received: by mail.test.com (Postfix, from userid 1001)
        id C625E127B; Tue, 17 Sep 2019 18:37:38 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.test.com (Postfix) with ESMTP id C1DB1E32;
        Tue, 17 Sep 2019 18:37:38 -0500 (CDT)
Date:   Tue, 17 Sep 2019 18:37:38 -0500 (CDT)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@lameter.cl
To:     David Rientjes <rientjes@google.com>
cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix -Wunused-function compiler warnings
In-Reply-To: <alpine.DEB.2.21.1909171423000.168624@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1909171837250.9981@lameter.cl>
References: <1568752232-5094-1-git-send-email-cai@lca.pw> <alpine.DEB.2.21.1909171423000.168624@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, David Rientjes wrote:

> Acked-by: David Rientjes <rientjes@google.com>

Ditto

