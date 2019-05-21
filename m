Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD28F25A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 00:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEUWkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 18:40:17 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:38953 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfEUWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 18:40:17 -0400
Received: by mail-qt1-f202.google.com with SMTP id b46so170586qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 15:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CxR5AlWDpArVLEx0HLe6lnTbiemspwxzj3fum4FdAg8=;
        b=a2KTTUPYY68mgnwLoZX7NpSamuPKa/UmPwh3ZXp/yHmS1liRwwJzfEOpVjkQVsGegs
         6StcJObJONEMW4BoSCAz3v0V84ruIgUSBpAkqjHte5mNxudvhWYOXjWrr1yAaOo70Ni2
         B+PnJGvCbugteJbXDXPpmFTtHbkNAYDPGoC4vaPDhxWwa3zD+c5WuQCs6jw/IrwcEBg4
         pN9GNTEhvTAO0EF2pA2C09Z2ieNP0ea7otA4B6ezj2yTvTslcHkPjU7pUrUV9nws7uJO
         7FJiK0RqG/f4trm++BfAF10+spOplapIV1LzayaMkLF19AnC2OhAMwPE3Ck//7irDXC/
         L3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CxR5AlWDpArVLEx0HLe6lnTbiemspwxzj3fum4FdAg8=;
        b=JHojxZRVoFQLw+fkneno2u/xFa/33k1/HhkCZHPaVCUqMiMY22IJwm8gCBFHZf3HLS
         Y6jGM9XNMmMXi6Qt4agGjNrZb/NeRKurrxPlhz19QwKXv2d/4nhCzx7EBjFpvuc5wdVC
         VpOh2oyu9rf0OgRUmScoN+neEHDSKcciY4ezJnzeafFEI3FhuNyn7/AKcfcP6kPWdVba
         ka8e0hDbCeSKLoeYF2ph3vQNFZV2rLeqw9CU3kEKecqZWFO9WWPQF/yOqIIqRIhZA2pH
         pSrQFS0sb0uBpVIAcuIjYBkxR2BrJeVCXWkUaTMzfnuEUz3Y4zuNsABbODUMiZX0KS1p
         XZDA==
X-Gm-Message-State: APjAAAVX4ZNwddjN64IzUz4frHI6tzciSJtKPSyYar2GogUggXMLqBnq
        3OqeD3Qi4T4Kvm/DVFN6vsyP448PzhtJm7N7T2N5pQ==
X-Google-Smtp-Source: APXvYqz4gdnvVuv7br9Lscej3ltCpnqgHO2bJjQda55zn6GOiF+J20YzxwBnrBHrqmZD6gAn0V2OPJ8Zkw9G2OvLC8Cs7Q==
X-Received: by 2002:a37:660d:: with SMTP id a13mr28849673qkc.347.1558478416387;
 Tue, 21 May 2019 15:40:16 -0700 (PDT)
Date:   Tue, 21 May 2019 15:40:11 -0700
Message-Id: <20190521224013.3782-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC] Turn lockdown into an LSM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

This is a quick attempt to integrate lockdown into the existing LSM
framework. It adds a new lockdown security hook and an LSM that defines
the existing coarse-grained policy, and also adds a new
DEFINE_EARLY_LSM() definition in order to permit lockdown (and
potentially other modules) to be initialised at the top of kernel init
in order to allow policy to be imposed on stuff that happens in
setup_arch(). The goal here is to allow policy to be devolved to other
LSMs on systems that have a secure mechanism for loading LSM policy
early in boot, allowing creation of arbitrarily complicated policies
without interfering with the common-case coarse-grained approach.

This should probably be extended so a uapi-exposed constant is passed to
the hook in order to make it easier to write policy in other LSMs, but
does this broadly look like you were imagining?


