Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A77ED419
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 19:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfKCSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 13:06:58 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:37792 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfKCSG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1572804417; bh=7pjVm27nDGGkGhe1qP2lKWsqupxdf5j9hCLSaFieWWk=;
        h=In-Reply-To:Date:Subject:From:To:Cc;
        b=h/UeDEfuWPN00Nv5n7+BebDwXrk+azrZNRiadueJR0MSNak3LPzGFpCKZ4IK4mwzg
         dwL0hdwloHBQ73PmrO6XCpp9DDr58CDKa+T/nYXm9Sp8T+N2a7d90Ib44nL+d0Hf+O
         HCTqLXshlOt36Wk3Up6XlFLktCmDSjnEbFywUJZc=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20191103180403.GA802745@kroah.com>
Date:   Sun, 03 Nov 2019 13:06:56 -0500
Subject: Re: [PATCH] firmware loader: log path to loaded firmwares
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Luis Chamberlain" <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <~sircmpwn/public-inbox@lists.sr.ht>
Message-Id: <BY6GMUEXH48C.TADRYV4JZ59N@homura>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fair enough, v2 sent. Thanks for the feedback!
