Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF4172317
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 17:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgB0QUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 11:20:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58070 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgB0QUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:20:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RG37SU156213;
        Thu, 27 Feb 2020 16:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=9Vt3KmBfr6qss9HnVAOBJ8DCQFUsK5SMylKYJ5xw3ls=;
 b=RA8/G5uto6hIJfj+y9n8MFIekWCdaK73Sk6oayt71fVvIze9BewmVMxGa+Cqbw8GFYA6
 hpshoPsE9XbPRjfr/ubQW1v0h34BmCGEBi9Yk1I3TiarP8lFVa6NcNGNg8ZN5c/aDlVO
 myxne9vbVYMZG9xCGmDF2yI3/5ZVXNI3u+mqRmtDjk8zb0faluGKJzgCxhDd0rcQ2kJ6
 TpiuyIqTwJwCSkSL3fd/Pbh62IUgxmbmK640yoE0TnIzW83N2fgw0B0P4Q7i/PZL6Gcz
 xkgV6ILZBr0PmcFd4KPK3e4Bbg7draVywr5nbW7GY/yCdu9/H2CpXucxZmDb7YFAQy6A aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2ydct3c1d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 16:20:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RGERW8186981;
        Thu, 27 Feb 2020 16:20:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ydcs5kst7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 16:20:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01RGK3Gx002382;
        Thu, 27 Feb 2020 16:20:03 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 08:20:03 -0800
Date:   Thu, 27 Feb 2020 19:19:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] tee: amdtee: out of bounds read in find_session()
Message-ID: <20200227161954.fo7pbbgomdjkraxq@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "index" is a user provided value from 0-USHRT_MAX.  If it's over
TEE_NUM_SESSIONS (31) then it results in an out of bounds read when we
call test_bit(index, sess->sess_mask).

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tee/amdtee/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 6370bb55f512..dbc238c7c263 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -139,6 +139,9 @@ static struct amdtee_session *find_session(struct amdtee_context_data *ctxdata,
 	u32 index = get_session_index(session);
 	struct amdtee_session *sess;
 
+	if (index >= TEE_NUM_SESSIONS)
+		return NULL;
+
 	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
 		if (ta_handle == sess->ta_handle &&
 		    test_bit(index, sess->sess_mask))
-- 
2.11.0

