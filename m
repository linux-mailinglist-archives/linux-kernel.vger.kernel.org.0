Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B8A99E79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbfHVSMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 14:12:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45796 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbfHVSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:12:54 -0400
Received: by mail-io1-f68.google.com with SMTP id t3so13737788ioj.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NvQFMd8K5JjgTwFlUzPCUuiowT1xqw5XzWyBVsyPasc=;
        b=uzwl0UN5mosDOhZ6VeiaCB4bF8Az4adpfsejJFpdTOgpyxiLYOvlyyzkl1X/S4PN3D
         f/dWPMAzbpr9DfbsvHPvXcxoE4YfDRLJBIAyl87g9T84aVoljKz55HsOtlPdLCSAdLaV
         qJAu5MdIdJ3FCg2uSDSMfDYRztN1lFN9UAYOc7cv3agrcrdC4jQ2+KF8GxeCXxXK1Yc1
         NAsx66dDXo87k6KRYyB2ra+1G8F9qsgcaYRly3tAw6yhOsZ7nW0Hc9SgmKPtI34RStBa
         cQckPNqeK0LxB+w0h7o+uVUMN7rtPX7805cHPLGEpGvOtSj/eKh/1Qv8YDW7UaWsa2u+
         TZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=NvQFMd8K5JjgTwFlUzPCUuiowT1xqw5XzWyBVsyPasc=;
        b=UyQWERb/y1S3HNwi6+V5gJu2dvcKrB7gWunDXEESjJWHvJV+M6OMz+YOSpl7mkm9xT
         TOwRRhS3ajR4ww+6sXArcQvubhzuHKnQR1XdH9yQtCAv1bNHB+A1CEgmn0HWfSmGreMk
         Kx3jNGQCcJDfLlNkjSWn7iiJ/41SYzxqo8DRW3Rwb2ISMHvbiH37KKk7Dzunp9CtEOW+
         nz93Aix5PXSDZ8SPv5tHyTAAqtEZyT8zMFdFB75TkvPQLBlUUTBOB07M6MvZai7QSZkb
         mEULbu5SkfDpab7RyHJIud6pDQwxadDq8whRuvlI6KrAFt+RbxTwAEN0mPpuUv21kQ+4
         jRsw==
X-Gm-Message-State: APjAAAVSMCU0Y8uBsqP27rL0TP5RbfSZ5mWSXTQZK/afAQD5yAeqQ8n2
        zcWmUWNs0tRrG3VGspOTrPAfCY7j44LexvcIrPM=
X-Google-Smtp-Source: APXvYqyaueNSkzvRe8Xx+/XW3YxqWhYf0NulKJDhZrIAfxik4CC7HbTZeUeSJ2gf9PefnYES6nKVGCizcbV17wAdA0k=
X-Received: by 2002:a5d:951a:: with SMTP id d26mr1266525iom.31.1566497573498;
 Thu, 22 Aug 2019 11:12:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: denizkargad@gmail.com
Received: by 2002:a4f:f4d1:0:0:0:0:0 with HTTP; Thu, 22 Aug 2019 11:12:52
 -0700 (PDT)
From:   Deniz KARGA <denizkagad@gmail.com>
Date:   Thu, 22 Aug 2019 11:12:52 -0700
X-Google-Sender-Auth: 43o7L9KJDEhSwbs5Lj6PDgkr3ac
Message-ID: <CAEhAppFAvwCBnSf2D1ErO5P6xar57ZDhDotfn-9POsPRdOhqLw@mail.gmail.com>
Subject: hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCknCoHNlbnTCoHlvdcKgYW7CoGVtYWlswqBlYXJsaWVywqBhbmTCoGJlZW7CoGV4cGVj
dGluZ8KgdG/CoGhlYXLCoGZyb23CoHlvdQ0KcmVnYXJkaW5nwqB0aGXCoGRlcG9zaXTCoG1hZGXC
oGF0wqBtecKgYmFua8KgaGVyZcKgaW7CoFR1cmtlecKgYnnCoGxhdGXCoEVuZ3LCoE0uTS4NClBs
ZWFzZcKgdHJ5wqBhbmTCoGdldMKgYmFja8KgdG/CoG1lLg0KDQpZb3Vycw0KRGVuaXoNCg==
