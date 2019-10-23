Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8EEE0F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 02:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfJWAds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 20:33:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30530 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727610AbfJWAds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571790827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L06TXI6Vj4mhhNtCHcisydZYDybVAGuxU9Mq4ab/6+0=;
        b=h4et94AgC7/fgPOxRvoBtoT8ios4g+yKzezLJwTilwraNucLWd+trq3hcsw4VjSQIUe2sd
        LU1v+XU3q4FzI2ktxqrH9Eq6CZIfuUTqIVjawYBPdGd/sSwEEp6cf6mMm0seE1P/argWmh
        TjlopVAT/J4vD5nOS94H56iMSleAeHk=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-uQfcw-WQPuaDfs0F42HDUQ-1; Tue, 22 Oct 2019 20:33:45 -0400
Received: by mail-yw1-f71.google.com with SMTP id o204so14444591ywc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L06TXI6Vj4mhhNtCHcisydZYDybVAGuxU9Mq4ab/6+0=;
        b=dkbaOyxUOKLTuKpGrgR2DSQOEBk0fYsBq2a4ezrTyaQtkGGcpgml1jIzln/6xamN9d
         ppVqjLb93GeEdeuOlQqskqrvjlaT8QYHDFViJBZzhtKy8J2YU8h3I0YJNsL/eOJeG67o
         /xkNAGvpiDXvO2sNd5Nx8N17xECNwSNZMMg0XopIndFvSHjsIilsIChfF4OW8neqVEUH
         s3IV4aKmi2fR+hbRvrPNDF2n6rH6JSQKabcuiGvAZpF2Tyjb3AyAKh/0+/kQB8GYNDBx
         Y4mnBVHH44d3P5k2dhr0vDGUl7ILEpkRlk30zOC3Xe1rm+qlkwtxH7MoD0a5O/ca0GKw
         mPEg==
X-Gm-Message-State: APjAAAWxlnIUgCNxQS+28/K6lYN49ST2GK9uJuxDNxAts8Eg2TlSe3JB
        6wdMRJ+IKl+VQRSRTvbRxzgQAnmrOf3kV82LnSKF+RUEygp1XiRXkn+APEsinq8iv0WYCsRhU23
        TR79gdahXQWmymg1bcZwlptjjVMNqTJgmj6310WJZ
X-Received: by 2002:a25:70c3:: with SMTP id l186mr2713973ybc.233.1571790824983;
        Tue, 22 Oct 2019 17:33:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHFatb7VN3aWeF2BTP2HzwmupBAgir8JASamIqoNVXs987KedyWPbTEyTBLNfMHnYICr1i78zqyEeaC3G4skU=
X-Received: by 2002:a25:70c3:: with SMTP id l186mr2713964ybc.233.1571790824789;
 Tue, 22 Oct 2019 17:33:44 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Rix <trix@redhat.com>
Date:   Tue, 22 Oct 2019 17:33:34 -0700
Message-ID: <CACVy4SX9qbe3D7ZVU9dredVcTrP9jd2LB0AaFUSmiPeqeaj8kg@mail.gmail.com>
Subject: [PATCH v2 0/1] xfrm : lock input tasklet skb queue
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Vehlow <lkml@jv-coder.de>
X-MC-Unique: uQfcw-WQPuaDfs0F42HDUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rev 2 is Jorg's original patch with some if-defs to lock only for RT.

I have tested Jorg's change, it works on RT and since it was first it
should take precedence.
I can appreciate not forcing the normal kernel to move ad-hoc to RT.
So I hope that the compromise of conditionally including the change
will be acceptable.

Tom

