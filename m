Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B018B9456
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404277AbfITPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 11:44:36 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37981 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403989AbfITPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:44:36 -0400
Received: from gandi.net (lmontsouris-657-1-214-187.w90-63.abo.wanadoo.fr [90.63.246.187])
        (Authenticated sender: thibaut.sautereau@clip-os.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 51A0A240008;
        Fri, 20 Sep 2019 15:44:34 +0000 (UTC)
Date:   Fri, 20 Sep 2019 17:44:34 +0200
From:   Thibaut Sautereau <thibaut.sautereau@clip-os.org>
To:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: dm-crypt error when CONFIG_CRYPTO_AUTHENC is disabled
Message-ID: <20190920154434.GA923@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got a dm-crypt "crypt: Error allocating crypto tfm" error when
trying to "cryptsetup open" a volume. I found out that it was only
happening when I disabled CONFIG_CRYPTO_AUTHENC.

drivers/md/dm-crypt.c includes the crypto/authenc.h header and seems to
use some CRYPTO_AUTHENC-related stuff. Therefore, shouldn't
CONFIG_DM_CRYPT select CONFIG_CRYPTO_AUTHENC?

-- 
Thibaut Sautereau
CLIP OS developer
