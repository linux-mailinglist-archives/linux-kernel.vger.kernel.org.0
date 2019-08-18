Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4F91A28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 01:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfHRXAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 19:00:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34225 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfHRXAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 19:00:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so13428pgc.1;
        Sun, 18 Aug 2019 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LxVWFPhmFrItVDiQhqvwlh/RdnoTsBda3sGp+wK8hDw=;
        b=rOBHwRkxTBPOgda6+qfDNpPSj6/ltCFauO4hnmLWCJAnhhI5uvcDV+nBYYtE7ABLgv
         ftM3nyblZQwhVkofwu7EMqYE2VGWnbM0ukpjhwYoME3a1wSWlMBsyKft0FiH9KjPcg0v
         M+wkN8qItpygUKe7tVPFELKLkBhBsw8a6uWbdEclmJS6VZ22LMVF+q6I56eiGLkPIprT
         7ptQIyE7TB5lYAtYZLcBf/RnULqewCFhYaklqZHKxrqZyRgpdu7qM20BPqj6bQHuPLQm
         s3vVrShLENFMjeWOC5qtpwFB/yV1Q5t+8iCTAeGRdZtRTlQB7Pl0nRw1EO3CP2PN3Z8p
         0wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LxVWFPhmFrItVDiQhqvwlh/RdnoTsBda3sGp+wK8hDw=;
        b=HIbjue317xS4hUxIhI9x5vme8WE+WhPW0T11pUBJ1YgTbwQWLlI5aHsbOIT/VxR2Xq
         hPmpK2x9qMDe7RKUA8O/igobK7W2vLX/PzU9C3csPXAUCuMgYSgcnhiyVR/VA/7ZP0vt
         vUEbarbImNZrCaluwrDFVxHqGjiKSVquaUK/2rIJSVtmBiAYssCPrSHHrICzloNyi5To
         WwAuVDlSaog04j9JRmdvuuzaCZMcgLcDvAH9sopMW040kAa+WghGVGD/SiTW2FlVm8ZP
         gm7qtjNoukhU84M7AzWNg/umbTR6NM8ZaaE2f/4laA0RkJkmGKDURpvUqudXo8vFLeIY
         h8hQ==
X-Gm-Message-State: APjAAAWsH/TD3g7EgwAQKqRReVVSY2ixwkqXaECK5TRnffxQHj/L9jNG
        7nq5WMmWtf5JoX8S8A1uQTZ7IUBf2wM=
X-Google-Smtp-Source: APXvYqw7oT/Z7sQLXU4UWr1BGw7eFkLOy40g/+vQzFYRBejZpTxIQDIrsufedkcClsOXFd8OQRszjw==
X-Received: by 2002:aa7:8a47:: with SMTP id n7mr22304140pfa.182.1566169224842;
        Sun, 18 Aug 2019 16:00:24 -0700 (PDT)
Received: from mbalantz-desktop (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id 185sm15700828pfd.125.2019.08.18.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 16:00:24 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
X-Google-Original-From: Mark Balantzyan <mbalantz@mbalantz-desktop>
Date:   Sun, 18 Aug 2019 16:00:20 -0700 (PDT)
To:     Julian Calaby <julian.calaby@gmail.com>
cc:     Mark Balantzyan <mbalant3@gmail.com>, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lsilogic mpt fusion: mptctl: Fixed race condition
 around mptctl_id variable using mutexes
In-Reply-To: <CAGRGNgUvZ0-GS=p8uVSEGA1Tca9HNg1W+Zrhc3ugxD2xqf0wBw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908181600050.25199@mbalantz-desktop>
References: <20190815100050.3924-1-mbalant3@gmail.com> <CAGRGNgUvZ0-GS=p8uVSEGA1Tca9HNg1W+Zrhc3ugxD2xqf0wBw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian, all,

I submitted a patch v4 following Julian's review. A function such as 
"mptctl_do_mpt_command" I don't think is a setup function and so the race 
condition (likelihood) remains. Again, this was mainly concerning the 
usage of "mptctl_id" variable in the driver. My objective was just to make 
it as safe as possible and improve it. Please accept my patch v4 should it 
suffice.

Thank you,

Mark
