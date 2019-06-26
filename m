Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA856BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 16:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfFZO3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 10:29:15 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:57229 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbfFZO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:29:15 -0400
Received: from h2730561.stratoserver.net (h2730561.stratoserver.net [85.214.29.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 771761F42E;
        Wed, 26 Jun 2019 16:29:12 +0200 (CEST)
From:   =?UTF-8?q?Tobias=20Nie=C3=9Fen?= 
        <tobias.niessen@stud.uni-hannover.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Subject: staging: rts5208: Two patches to improve code style
Date:   Wed, 26 Jun 2019 16:28:55 +0200
Message-Id: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches improve the code style in the rts5208 staging
driver. Many other style issues cannot be resolved without much more
extensive refactoring.


