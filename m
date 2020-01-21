Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5A14459F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 21:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAUUDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 15:03:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37414 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:03:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so2094230pga.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 12:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfjJsIdbdeYfyoWYZI/v+xL9rsxmnFotagk/efJxZeQ=;
        b=Dl+0Mm4wp0jO8VhSxSjgZYlXNa7+CtoQ1TxEwHldbo8iKofTT/JBSl5vqLmaMvqLEv
         +yX/GmZ1nmJ2Nx1AVhCk57wU+/3+k0byzqUmrusAW2gGDJEDCb//X2bKpvmWIEg1vjaI
         pD1CeR2SOZq6cyjLENDYoQzuEhW+b0gbxr/rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qfjJsIdbdeYfyoWYZI/v+xL9rsxmnFotagk/efJxZeQ=;
        b=ZRCfCceV/PAXWuKdToNuXOa5Ztp8AqY8mvob3Dw4B66bBYN4L0WmiItToWJZTw28nk
         meqKLK+LmyEzjPbyOYBjvcqv+OB0a2VhyGlFqMrt2dBRyADMd890fASuFETwTS3KVO3A
         mbNL8yOjjA4cgJWDMNgzzo3dF9lXF8EjmE3EV2o5AJ3hvpgtNhXjMsNgcZsK9yZSoIbO
         tyja2Kg+wqyAzOEReJqWTRTaUF9Gel7A042E8FKiqNLWzEIgJoSggWYULSyQuwOOSWqN
         6jl3r8/Nz3IYKQBl7uI90Fdts4GEClspJU7Wow7xXr9NlZp3I/hsRhxc7Wa6XtKfWHpL
         3ANw==
X-Gm-Message-State: APjAAAUNv7wyZiOXRg2SQWHnVlTRhp1ljPbkta52a+WfceE8/6m9cRnE
        buIFMbxzpbk1zXlChy+L9o+6
X-Google-Smtp-Source: APXvYqyEoBwWx6wBKuPT6zGG4QM5u1aLC20Yjv0f39wc6CnGmiPwGyCwxuRptRm2JhWaO3yp+dEoug==
X-Received: by 2002:a63:904c:: with SMTP id a73mr7316944pge.335.1579637014774;
        Tue, 21 Jan 2020 12:03:34 -0800 (PST)
Received: from fa2cb4acc48b.colo.rubrik.com ([4.7.92.14])
        by smtp.gmail.com with ESMTPSA id w3sm40524754pgj.48.2020.01.21.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:03:34 -0800 (PST)
From:   "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>
Cc:     Chaitanya.Kulkarni@wdc.com,
        "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Adding multiple workers to the loop device.
Date:   Tue, 21 Jan 2020 20:03:21 +0000
Message-Id: <20200121200323.52287-1-muraliraja.muniraju@rubrik.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the dd results that I ran with the worker and without the worker changes. 
Enhanced Loop has the changes and ran with 1,2,3,4 workers with 4 dds running on the same loop device.
Normal Loop is 1 worker(the existing code) with 4 dd's running on the same loop device.
Enhanced loop
1 - READ: io=21981MB, aggrb=187558KB/s, minb=187558KB/s, maxb=187558KB/s, mint=120008msec, maxt=120008msec
2 - READ: io=41109MB, aggrb=350785KB/s, minb=350785KB/s, maxb=350785KB/s, mint=120004msec, maxt=120004msec
3 - READ: io=45927MB, aggrb=391802KB/s, minb=391802KB/s, maxb=391802KB/s, mint=120033msec, maxt=120033msec
4 - READ: io=45771MB, aggrb=390543KB/s, minb=390543KB/s, maxb=390543KB/s, mint=120011msec, maxt=120011msec
Normal loop
1 - READ: io=18432MB, aggrb=157201KB/s, minb=157201KB/s, maxb=157201KB/s, mint=120065msec, maxt=120065msec
2 - READ: io=18762MB, aggrb=160035KB/s, minb=160035KB/s, maxb=160035KB/s, mint=120050msec, maxt=120050msec
3 - READ: io=18174MB, aggrb=155058KB/s, minb=155058KB/s, maxb=155058KB/s, mint=120020msec, maxt=120020msec
4 - READ: io=20559MB, aggrb=175407KB/s, minb=175407KB/s, maxb=175407KB/s, mint=120020msec, maxt=120020msec

The Enhanced loop is the current patch with number of workers to be 4. Beyond 4 workers I did not see a significant changes.
