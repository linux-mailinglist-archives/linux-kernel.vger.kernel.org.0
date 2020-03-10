Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69BF17F59A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 12:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgCJLEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 07:04:31 -0400
Received: from mx.sdf.org ([205.166.94.20]:60698 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgCJLEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:04:30 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2020 07:04:30 EDT
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02AAtqUs002320
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Tue, 10 Mar 2020 10:55:53 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02AAtqjn009972;
        Tue, 10 Mar 2020 10:55:52 GMT
Date:   Tue, 10 Mar 2020 10:55:52 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, George Spelvin <lkml@sdf.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] int128: fix __uint128_t compiler test in Kconfig
Message-ID: <20200310105552.GA24925@SDF.ORG>
References: <20200310101250.22374-1-masahiroy@kernel.org>
 <20200310101250.22374-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310101250.22374-2-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!  As your 1/2 commit message explained, the best way to fix
this was not entirely obvious.

FWIW, this series
Tested-by: George Spelvin <lkml@sdf.org>
