Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61B749B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 09:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfFRH4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 03:56:33 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:37667 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFRH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:56:32 -0400
Date:   Tue, 18 Jun 2019 07:56:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1560844590;
        bh=65+C5sAXGkplAKNqz3BotihBJoYXAbxTNdDd1KqjmRE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=1frkddWpR0JAY/Er2JfvjKlZaSHep3xNbjE2bbyJOmTSax2cQ4zUjsM5uRiQv/ko8
         yhICsZpgfYdaUE9RpT4lR5CaVgT+7v6weB+5KcgZdCpnG9kyaYyYbd2WYNmVIHyf7p
         Vfjyqlcze/zi10KFLp7sogZGq/PedWoKAU7FqqnM=
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH V2 4/5] drm/vkms: Use index instead of 0 in possible crtc
Message-ID: <innWfwO1f7V6XAA8IXBBqGMw-4_upKRtjsPG8kg19Pl9b2Hf3Bd4V20Ow7GWhfzNUmij1uVwMuHbOp3zGderuXZGhunI0y_-khuFTOStOkI=@emersion.fr>
In-Reply-To: <971da2ede86d11357e6822409bef23cb03869f83.1560820888.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
 <971da2ede86d11357e6822409bef23cb03869f83.1560820888.git.rodrigosiqueiramelo@gmail.com>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interestingly, even with the previous code, possible_crtcs=3D1 was
exposed to userspace [1]. I think this is because of a safeguard in
drm_crtc_init_with_planes (drm_crtc.c:284) which sets the primary and
cursor plane's possible_crtcs to the first CRTC if zero.

If we want to warn on possible_crtcs=3D0, we should probably remove this
safeguard. Checking first whether this safeguard is used by any driver
is probably a good idea.

[1]: https://drmdb.emersion.fr/devices/f218d1242714
